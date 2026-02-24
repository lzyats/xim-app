package lansoft.com

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Intent
import android.graphics.Color
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.os.PowerManager
import android.provider.Settings
import android.util.Log
import android.view.Gravity
import android.view.View
import android.view.WindowManager
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.annotation.NonNull
import androidx.core.app.NotificationCompat
import com.alibaba.fastjson.JSONObject
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
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.util.WeakHashMap

import android.content.ComponentName
import android.content.pm.PackageManager
import android.view.WindowInsets

class MainActivity : FlutterFragmentActivity() {
    // ===================== 常量定义 =====================
    private val TAG = "MainActivity"
    private val WAKEUP_CHANNEL = "lansoft.com/wakeup"
    private val UNI_EVENT_CHANNEL = "flutter_uni_stream"
    private val UNI_METHOD_CHANNEL = "flutter_uni_channel"
    private val LAUNCH_PARAMS_CHANNEL = "lansoft.com/launchParams"
    private val SYSTEM_CHANNEL = "lansoft.com/system"

    // ===================== 成员变量 =====================
    private val unimpMap = WeakHashMap<String, IUniMP>()
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
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        super.configureFlutterEngine(flutterEngine)
        registerChannels(flutterEngine)
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

        // wakeup
        MethodChannel(messenger, WAKEUP_CHANNEL).setMethodCallHandler(this::handleWakeupMethods)

        // UniMP event stream
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

        // UniMP methods
        MethodChannel(messenger, UNI_METHOD_CHANNEL).setMethodCallHandler(this::handleUniMPMethods)

        // launch params
        MethodChannel(messenger, LAUNCH_PARAMS_CHANNEL).setMethodCallHandler { call, result ->
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

        // ✅ system / navigation mode
        MethodChannel(messenger, SYSTEM_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getNavigationMode" -> result.success(getNavigationMode())
                "isGestureNavigation" -> result.success(getNavigationMode() == "gesture")
                else -> result.notImplemented()
            }
        }
    }

    // ===================== 唤醒功能处理 =====================
    private fun handleWakeupMethods(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "wakeUp") {
            val callData = call.arguments as? Map<String, String>
            val callType = callData?.get("callType") ?: "voice"
            val channel = callData?.get("channel") ?: ""
            val chatId = callData?.get("chatId") ?: ""

            val powerManager = getSystemService(POWER_SERVICE) as PowerManager
            val wakeLock = powerManager.newWakeLock(
                PowerManager.SCREEN_BRIGHT_WAKE_LOCK or PowerManager.ACQUIRE_CAUSES_WAKEUP,
                "MyApp:WakeLockTag"
            )
            wakeLock.acquire(10 * 1000L)

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) {
                setShowWhenLocked(true)
                setTurnScreenOn(true)
            } else {
                window.addFlags(
                    WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED
                            or WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON
                )
            }

            val intent = packageManager.getLaunchIntentForPackage(packageName)?.apply {
                addFlags(
                    Intent.FLAG_ACTIVITY_REORDER_TO_FRONT
                            or Intent.FLAG_ACTIVITY_NEW_TASK
                            or Intent.FLAG_ACTIVITY_CLEAR_TOP
                )
                putExtra("callType", callType)
                putExtra("channel", channel)
                putExtra("chatId", chatId)
                putExtra("isIncomingCall", true)
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
            val eventData = JSONObject().apply {
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

        val eventData = JSONObject().apply {
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

    // ===================== ✅ 导航模式检测（国产机强化版） =====================

    private fun getNavigationMode(): String {
        // 返回：gesture / three_button / two_button / unknown

        val manu = (Build.MANUFACTURER ?: "").lowercase()

        // =====================
        // 1) 通用：navigation_mode（Secure）
        // 0=3-button, 1=2-button, 2=gesture
        // =====================
        readIntSetting {
            Settings.Secure.getInt(contentResolver, "navigation_mode")
        }?.let { mode ->
            return when (mode) {
                0 -> "three_button"
                1 -> "two_button"
                2 -> "gesture"
                else -> "unknown"
            }
        }

        // =====================
        // 2) 通用：navigation_mode（Global）
        // =====================
        readIntSetting {
            Settings.Global.getInt(contentResolver, "navigation_mode")
        }?.let { mode ->
            return when (mode) {
                0 -> "three_button"
                1 -> "two_button"
                2 -> "gesture"
                else -> "unknown"
            }
        }

        // =====================
        // 3) 小米 / 红米 / POCO（MIUI / HyperOS）
        // =====================
        if (manu.contains("xiaomi") || manu.contains("redmi") || manu.contains("poco")) {
            readIntSetting {
                Settings.Global.getInt(contentResolver, "force_fsg_nav_bar")
            }?.let { v ->
                if (v == 1) return "gesture"
                if (v == 0) return "three_button"
            }

            // 少量 ROM 的拼写变体
            readIntSetting {
                Settings.Global.getInt(contentResolver, "forse_fsg_nav_bar")
            }?.let { v ->
                if (v == 1) return "gesture"
                if (v == 0) return "three_button"
            }
        }

        // =====================
        // 4) 一加 / OPPO / ColorOS 系
        // OnePlus 8+ / ColorOS 12+ 实测有效
        // =====================
        if (
            manu.contains("oneplus") ||
            manu.contains("oppo")
        ) {
            // 隐藏导航栏（手势时常为 1）
            readIntSetting {
                Settings.Secure.getInt(contentResolver, "hide_navigationbar_enable")
            }?.let { v ->
                if (v == 1) return "gesture"
                if (v == 0) return "three_button"
            }

            // 部分系统直接给手势开关
            readIntSetting {
                Settings.Secure.getInt(contentResolver, "navigation_gesture_on")
            }?.let { v ->
                if (v == 1) return "gesture"
                if (v == 0) return "three_button"
            }
        }

        // =====================
        // 5) 最终兜底：WindowInsets（API 29+）
        // =====================
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            try {
                val insets = window.decorView.rootWindowInsets
                if (insets != null) {
                    val gestureBottom = insets.systemGestureInsets.bottom
                    val threshold = (24 * resources.displayMetrics.density).toInt()

                    if (gestureBottom >= threshold) {
                        return "gesture"
                    }

                    val navBottom =
                        insets.getInsets(android.view.WindowInsets.Type.navigationBars()).bottom
                    if (navBottom >= threshold) {
                        return "three_button"
                    }
                }
            } catch (_: Throwable) {
            }
        }

        return "unknown"
    }


    private fun readIntSetting(getter: () -> Int): Int? {
        return try {
            getter()
        } catch (_: Throwable) {
            null
        }
    }

    // ===================== 工具方法 =====================
    private fun Int.dp(): Int = (this * resources.displayMetrics.density).toInt()
}
