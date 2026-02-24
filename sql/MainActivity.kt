package com.lkim.xyz

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
import android.content.Context
import android.view.WindowInsets

class MainActivity : FlutterFragmentActivity() {
    // ===================== 常量定义 =====================
    private val TAG = "MainActivity"
    private val WAKEUP_CHANNEL = "lansoft.com/wakeup"
    private val UNI_EVENT_CHANNEL = "flutter_uni_stream"
    private val UNI_METHOD_CHANNEL = "flutter_uni_channel"
    private val NAVIGATION_TYPE_CHANNEL = "navigation_type" // 重命名为 NAVIGATION_TYPE_CHANNEL 以避免混淆
    private val LAUNCH_PARAMS_CHANNEL = "lansoft.com/launchParams" // 提取为常量

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
        super.configureFlutterEngine(flutterEngine)
        // 1. 注册 Flutter 插件
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        // 2. 注册所有自定义的 Method Channel 和 Event Channel
        registerCustomChannels(flutterEngine)
    }

    override fun onDestroy() {
        super.onDestroy()
        unimpMap.clear()
        uniMpJsCallback = null
        eventSink = null
        pendingOverlayResult = null
    }

    // ===================== 通道注册与处理 =====================
    /**
     * 统一注册所有自定义 Channel
     */
    private fun registerCustomChannels(flutterEngine: FlutterEngine) {
        val messenger = flutterEngine.dartExecutor.binaryMessenger

        // 唤醒功能通道
        MethodChannel(messenger, WAKEUP_CHANNEL).setMethodCallHandler(this::handleWakeupMethods)

        // UniMP 事件流通道
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

        // UniMP 方法调用通道
        MethodChannel(messenger, UNI_METHOD_CHANNEL).setMethodCallHandler(this::handleUniMPMethods)

        // 获取启动参数通道
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

        // 获取导航类型通道
        MethodChannel(messenger, NAVIGATION_TYPE_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getNavigationType") {
                val navigationType = getNavigationType()
                result.success(navigationType)
            } else {
                result.notImplemented()
            }
        }

    }

    // ===================== 全屏设置方法 =====================
    // (你的代码中这部分是空的，如果有具体实现可以加在这里)

    // ===================== 唤醒功能处理 =====================
    private fun handleWakeupMethods(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "wakeUp") {
            // 获取通话参数
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

            // 解锁屏幕（部分机型需要）
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) {
                setShowWhenLocked(true)
                setTurnScreenOn(true)
            } else {
                window.addFlags(
                    WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED
                            or WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON
                )
            }

            // 构建启动意图
            val intent = packageManager.getLaunchIntentForPackage(packageName)?.apply {
                addFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT
                        or Intent.FLAG_ACTIVITY_NEW_TASK
                        or Intent.FLAG_ACTIVITY_CLEAR_TOP)
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

    /**
     * 判断导航类型（传统三键、手势导航等）
     * 直接集成在 MainActivity 中
     */
    private fun getNavigationType(): String {
        // 方法1: 使用 WindowInsets API (Android 10, API 29+)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            return try {
                val windowManager = getSystemService(Context.WINDOW_SERVICE) as WindowManager
                val windowInsets = windowManager.currentWindowMetrics.windowInsets

                // isVisible() 会返回当前导航栏是否可见
                // 对于手势导航，这个Insets通常是不可见的或高度为0
                val isGestureNavigation = !windowInsets.isVisible(WindowInsets.Type.navigationBars())

                if (isGestureNavigation) "gesture" else "traditional"
            } catch (e: Exception) {
                // 如果API调用失败，回退到方法2
                getNavigationTypeBySystemProperty()
            }
        }
        // 方法2: 通过反射获取系统属性 (兼容 Android 10 以下版本)
        else {
            return getNavigationTypeBySystemProperty()
        }
    }

    /**
     * 通过反射获取系统属性来判断导航类型 (辅助方法)
     */
    private fun getNavigationTypeBySystemProperty(): String {
        return try {
            val systemPropertiesClass = Class.forName("android.os.SystemProperties")
            val getMethod = systemPropertiesClass.getDeclaredMethod("get", String::class.java)

            // "navigationbar.mode" 属性在很多设备上有效
            // 0 或未设置 -> 传统导航
            // 1 -> 手势导航
            val navMode = getMethod.invoke(null, "navigationbar.mode") as String?

            if (navMode == "1") "gesture" else "traditional"
        } catch (e: Exception) {
            // 如果所有方法都失败，默认返回传统导航
            "gesture"
        }
    }

    // ===================== 工具方法 =====================
    private fun Int.dp(): Int = (this * resources.displayMetrics.density).toInt()
}