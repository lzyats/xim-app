package lansoft.com

import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.util.Log
import android.view.Gravity
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.annotation.NonNull
import com.alibaba.fastjson.JSONObject  // 仅保留fastjson的JSONObject
import io.dcloud.feature.sdk.DCSDKInitConfig
import io.dcloud.feature.sdk.DCUniMPSDK
import io.dcloud.feature.sdk.Interface.IUniMP
import io.dcloud.feature.sdk.MenuActionSheetItem
import io.dcloud.feature.unimp.DCUniMPJSCallback
import io.dcloud.feature.unimp.config.UniMPOpenConfiguration
import io.dcloud.feature.unimp.config.UniMPReleaseConfiguration
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall  // 导入MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.util.WeakHashMap  // 必须添加此导入
// 在文件开头的导入区域添加
import android.os.PowerManager

import android.os.Handler
import android.os.Looper

// 1. 导入 Bundle 类（用于传递数据）
import android.os.Bundle

// 2. 导入通知相关类（NotificationChannel/NotificationManager 等）
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent

// 3. 导入 AndroidX 通知兼容类（NotificationCompat，需确保依赖已添加）
import androidx.core.app.NotificationCompat

class MainActivity : FlutterFragmentActivity() {
    // ===================== 常量定义 =====================
    private val TAG = "MainActivity"
    private val WAKEUP_CHANNEL = "lansoft.com/wakeup"
    private val UNI_EVENT_CHANNEL = "flutter_uni_stream"
    private val UNI_METHOD_CHANNEL = "flutter_uni_channel"

    // ===================== 成员变量 =====================
    private val unimpMap = WeakHashMap<String, IUniMP>()  // 已导入WeakHashMap
    private var uniMpJsCallback: DCUniMPJSCallback? = null
    private var eventSink: EventChannel.EventSink? = null
    private var pendingOverlayResult: MethodChannel.Result? = null

    // ===================== Activity Result 注册 =====================
    private val overlayPermissionLauncher: ActivityResultLauncher<Intent> =
        registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { _ ->
            pendingOverlayResult?.let { result ->
                val hasPermission = Build.VERSION.SDK_INT < Build.VERSION_CODES.M ||
                        Settings.canDrawOverlays(this@MainActivity)
                result.success(hasPermission)
                pendingOverlayResult = null
            }
        }

    // ===================== 核心生命周期 =====================
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        registerChannels(flutterEngine)
        // 删除未实现的initUniMPListeners()调用
    }

    override fun onDestroy() {
        super.onDestroy()
        unimpMap.clear()
        uniMpJsCallback = null
        eventSink = null
        pendingOverlayResult = null
    }

    // ===================== 通道注册与处理 =====================
    private fun registerChannels(flutterEngine: FlutterEngine) {
        val messenger = flutterEngine.dartExecutor.binaryMessenger

        MethodChannel(messenger, WAKEUP_CHANNEL).setMethodCallHandler(this::handleWakeupMethods)
        EventChannel(messenger, UNI_EVENT_CHANNEL).setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
                eventSink = events
                Log.d(TAG, "EventChannel connected")
            }

            override fun onCancel(arguments: Any?) {
                eventSink = null
                Log.w(TAG, "EventChannel disconnected")
            }
        })
        MethodChannel(messenger, UNI_METHOD_CHANNEL).setMethodCallHandler(this::handleUniMPMethods)
        // 在 MainActivity.kt 的 registerChannels 方法中添加
        MethodChannel(messenger, "lansoft.com/launchParams").setMethodCallHandler { call, result ->
            if (call.method == "getLaunchParams") {
                val params = mutableMapOf<String, Any?>()
                intent.extras?.let { extras ->
                    params["callType"] = extras.getString("callType")
                    params["channel"] = extras.getString("channel")
                    params["chatId"] = extras.getString("chatId")
                    params["isIncomingCall"] = extras.getBoolean("isIncomingCall", false)
                }
                result.success(params)
            } else {
                result.notImplemented()
            }
        }
    }


    // ===================== 唤醒功能处理 =====================
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // 初始化通知渠道
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                "call_channel",
                "通话通知",
                NotificationManager.IMPORTANCE_HIGH
            )
            val notificationManager = getSystemService(NotificationManager::class.java)
            notificationManager.createNotificationChannel(channel)
        }
    }
    // 文件路径：xim-app/android/app/src/main/kotlin/com/platform/alpaca/MainActivity.kt
    private fun handleWakeupMethods(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "wakeUp") {
            // 获取通话参数（从 Flutter 层传递）
            val callData = call.arguments as? Map<String, String>
            val callType = callData?.get("callType") ?: "voice"
            val channel = callData?.get("channel") ?: ""
            val chatId = callData?.get("chatId") ?: ""

            // 唤醒屏幕
            val powerManager = getSystemService(POWER_SERVICE) as PowerManager
            val wakeLock = powerManager.newWakeLock(
                PowerManager.SCREEN_BRIGHT_WAKE_LOCK or PowerManager.ACQUIRE_CAUSES_WAKEUP,
                "MyApp:WakeLockTag"
            )
            wakeLock.acquire(10*1000L)

            // 构建启动 MainActivity 的 Intent，并传递通话参数
            val intent = packageManager.getLaunchIntentForPackage(packageName)?.apply {
                addFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT 
                        or Intent.FLAG_ACTIVITY_NEW_TASK 
                        or Intent.FLAG_ACTIVITY_CLEAR_TOP)
                // 传递参数给 Flutter 层（用于打开对应通话页面）
                putExtra("callType", callType)
                putExtra("channel", channel)
                putExtra("chatId", chatId)
                putExtra("isIncomingCall", true) // 标记为来电，用于 Flutter 层判断
            }

            intent?.let {
                startActivity(it)
                result.success(true)
            } ?: run {
                result.error("LAUNCH_ERROR", "启动意图获取失败", null)
            }
        } else {
            result.notImplemented()
        }
    }

    // ===================== UniMP 核心逻辑封装 =====================
    private fun handleUniMPMethods(call: MethodCall, result: MethodChannel.Result) {
        try {
            when (call.method) {
                "initMP" -> initUniMP(result)
                "versionMP" -> getUniMPVersion(call, result)
                "installMP" -> installUniMP(call, result)
                "openMP" -> openUniMP(call, result)
                "hideMP" -> hideUniMP(call, result)
                "closeMP" -> closeUniMP(call, result)
                "sendMP" -> sendEventToUniMP(call, result)
                "callbackMP" -> sendCallbackToUniMP(call, result)
                else -> result.notImplemented()
            }
        } catch (e: Exception) {
            Log.e(TAG, "UniMP方法执行失败: ${call.method}", e)
            result.error("UNIMP_ERROR", e.message, e.stackTraceToString())
        }
    }

    private fun initUniMP(result: MethodChannel.Result) {
        if (DCUniMPSDK.getInstance().isInitialize()) {
            result.success(true)
            return
        }

        val menuItems = ArrayList<MenuActionSheetItem>()
        val config = DCSDKInitConfig.Builder()
            .setCapsule(true)
            .setMenuDefFontSize("16px")
            .setMenuDefFontColor("#2D2D2D")
            .setMenuDefFontWeight("normal")
            .setMenuActionSheetItems(menuItems)
            .build()

        DCUniMPSDK.getInstance().initialize(this, config)
        result.success(true)
    }

    private fun getUniMPVersion(call: MethodCall, result: MethodChannel.Result) {
        val appId = call.argument<String>("appId") ?: ""
        val versionInfo = mutableMapOf<String, Any>("name" to "0.0.0", "code" to 0)

        if (DCUniMPSDK.getInstance().isExistsApp(appId)) {
            val info = DCUniMPSDK.getInstance().getAppVersionInfo(appId)
            versionInfo["name"] = info.getString("name")
            versionInfo["code"] = info.getInt("code")
        }
        result.success(versionInfo)
    }

    private fun installUniMP(call: MethodCall, result: MethodChannel.Result) {
        val appId = call.argument<String>("appId") ?: ""
        val wgtPath = call.argument<String>("wgtPath") ?: ""

        val config = UniMPReleaseConfiguration().apply { this.wgtPath = wgtPath }
        DCUniMPSDK.getInstance().releaseWgtToRunPath(appId, config) { code, _ ->
            result.success(code == 1)
        }
    }

    private fun openUniMP(call: MethodCall, result: MethodChannel.Result) {
        val appId = call.argument<String>("appId") ?: ""
        val isReload = call.argument<Boolean>("isreload") ?: false
        val configMap = call.argument<HashMap<String, Any>>("config") ?: hashMapOf()

        if (unimpMap.containsKey(appId) && !isReload) {
            // 明确使用com.alibaba.fastjson.JSONObject
            val eventData = com.alibaba.fastjson.JSONObject().apply {
                put("appId", appId)
                put("data", configMap["extraData"])
            }
            unimpMap[appId]?.sendUniMPEvent("open_app", eventData)
            unimpMap[appId]?.showUniMP()
            result.success(true)
            return
        }

        val openConfig = UniMPOpenConfiguration().apply {
            val extraData = configMap["extraData"] as? HashMap<String, Any>
            if (extraData != null) {
                // 此处使用org.json.JSONObject（若必须），需显式导入并处理冲突
                val json = org.json.JSONObject()
                extraData.forEach { (k, v) -> json.put(k, v) }
                json.put("path", configMap["path"] as? String)
                this.extraData = json
            }
            this.path = configMap["path"] as? String
        }

        val uniMP = DCUniMPSDK.getInstance().openUniMP(applicationContext, appId, openConfig)
        unimpMap[appId] = uniMP
        result.success(true)
    }

    private fun hideUniMP(call: MethodCall, result: MethodChannel.Result) {
        val appId = call.argument<String>("appId") ?: ""
        unimpMap[appId]?.hideUniMP()
        result.success(true)
    }

    private fun closeUniMP(call: MethodCall, result: MethodChannel.Result) {
        val appId = call.argument<String>("appId") ?: ""
        unimpMap.remove(appId)?.closeUniMP()
        result.success(true)
    }

    private fun sendEventToUniMP(call: MethodCall, result: MethodChannel.Result) {
        val appId = call.argument<String>("appId") ?: ""
        val event = call.argument<String>("event") ?: ""
        val data = call.argument<Any>("data") ?: ""

        // 明确使用com.alibaba.fastjson.JSONObject
        val eventData = com.alibaba.fastjson.JSONObject().apply {
            put("appId", appId)
            put("event", event)
            put("data", data)
        }
        unimpMap[appId]?.sendUniMPEvent(event, eventData)
        result.success(true)
    }

    private fun sendCallbackToUniMP(call: MethodCall, result: MethodChannel.Result) {
        val data = call.argument<Any>("data") ?: ""
        uniMpJsCallback?.invoke(data)
        result.success(true)
    }

    // ===================== 工具方法 =====================
    // 修复dp扩展函数：定义为方法（需加()调用）
    private fun Int.dp(): Int = (this * resources.displayMetrics.density).toInt()
}