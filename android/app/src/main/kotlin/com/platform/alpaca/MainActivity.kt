package myeim.im

import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.util.Log
import android.view.Gravity
import android.view.WindowManager
import android.widget.TextView
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

class MainActivity : FlutterFragmentActivity() {
    // ===================== 常量定义 =====================
    private val TAG = "MainActivity"
    private val OVERLAY_CHANNEL = "myeim.im/overlay"
    private val WAKEUP_CHANNEL = "myeim.im/wakeup"
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

        MethodChannel(messenger, OVERLAY_CHANNEL).setMethodCallHandler(this::handleOverlayMethods)
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
    }

    // ===================== 浮窗权限方法处理 =====================
    private fun handleOverlayMethods(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "requestOverlayPermission" -> {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && !Settings.canDrawOverlays(this)) {
                    val intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION, Uri.parse("package:$packageName"))
                    pendingOverlayResult = result
                    overlayPermissionLauncher.launch(intent)
                } else {
                    result.success(true)
                }
            }
            "showCallOverlay" -> {
                val eventData = call.argument<String>("eventData")
                showCallOverlay(eventData)
                result.success(true)
            }
            else -> result.notImplemented()
        }
    }

    private fun showCallOverlay(eventData: String?) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && !Settings.canDrawOverlays(this)) {
            Log.w(TAG, "浮窗权限未授予，无法显示浮窗")
            return
        }

        val windowManager = getSystemService(WINDOW_SERVICE) as WindowManager
        val overlayView = TextView(this).apply {
            text = "通话浮窗: $eventData"
            setTextColor(android.graphics.Color.WHITE)
            // 修复withAlpha：改用argb设置透明度（兼容所有版本）
            setBackgroundColor(android.graphics.Color.argb(180, 0, 0, 0))  // 180=透明度（0-255），0,0,0=黑色
            // 修复dp调用：扩展函数改为方法，调用时加()
            setPadding(16.dp(), 16.dp(), 16.dp(), 16.dp())
            gravity = Gravity.CENTER
        }

        val params = WindowManager.LayoutParams().apply {
            type = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
            } else {
                @Suppress("DEPRECATION")
                WindowManager.LayoutParams.TYPE_SYSTEM_ALERT
            }
            flags = WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE
            width = WindowManager.LayoutParams.WRAP_CONTENT
            height = WindowManager.LayoutParams.WRAP_CONTENT
            gravity = Gravity.TOP or Gravity.START
            x = 100
            y = 200
        }

        try {
            windowManager.addView(overlayView, params)
        } catch (e: Exception) {
            Log.e(TAG, "浮窗添加失败: ${e.message}", e)
        }
    }

    // ===================== 唤醒功能处理 =====================
    private fun handleWakeupMethods(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "wakeUp") {
            packageManager.getLaunchIntentForPackage(packageName)?.let { intent ->
                intent.addFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT)
                
                // 获取唤醒锁
                val powerManager = getSystemService(POWER_SERVICE) as PowerManager
                val wakeLock = powerManager.newWakeLock(
                    PowerManager.SCREEN_BRIGHT_WAKE_LOCK or PowerManager.ACQUIRE_CAUSES_WAKEUP,
                    "MyApp:WakeLockTag"
                )
                wakeLock.acquire(10*1000L) // 保持唤醒10秒（自动释放）
                
                // 启动Activity
                startActivity(intent)
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