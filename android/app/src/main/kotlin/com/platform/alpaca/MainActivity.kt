package com.platform.alpaca

import androidx.annotation.NonNull
import com.alibaba.fastjson.JSONObject
import io.dcloud.feature.sdk.DCSDKInitConfig
import io.dcloud.feature.sdk.DCUniMPSDK
import io.dcloud.feature.sdk.Interface.IUniMP
import io.dcloud.feature.sdk.MenuActionSheetItem
import io.dcloud.feature.unimp.DCUniMPJSCallback
import io.dcloud.feature.unimp.config.UniMPOpenConfiguration
import io.dcloud.feature.unimp.config.UniMPReleaseConfiguration
import io.flutter.Log
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterFragmentActivity() {
    /* ======================================================= */
    /* Override/Implements Methods                             */
    /* ======================================================= */
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        val messenger = flutterEngine.dartExecutor.binaryMessenger
        // Channel 对象
        val unimpMap = mutableMapOf<String?, IUniMP?>()
        var eventSink: EventChannel.EventSink? = null
        val event = EventChannel(messenger, "flutter_uni_stream")
        var uniMpcallback: DCUniMPJSCallback? = null
        val channel = MethodChannel(messenger, "flutter_uni_channel")

        event.setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
                        eventSink = events
                        Log.d("Android", "EventChannel onListen called")
                    }
                    override fun onCancel(arguments: Any?) {
                        Log.w("Android", "EventChannel onCancel called")
                    }
                })
        // Channel 设置回调
        channel.setMethodCallHandler { call, res ->
            // 根据方法名，分发不同的处理
            when (call.method) {
                "initMP" -> {
                    try {
                        if (DCUniMPSDK.getInstance().isInitialize()) {
                            res.success(true)
                        } else {
                            // 初始化uniMPSDK
//                            val item = MenuActionSheetItem("关于", "about")
                            val sheetItems = ArrayList<MenuActionSheetItem>()
//                            sheetItems.add(item)

                            val config = DCSDKInitConfig.Builder()
                                    .setCapsule(true)
                                    .setMenuDefFontSize("16px")
                                    .setMenuDefFontColor("#2D2D2D")
                                    .setMenuDefFontWeight("normal")
                                    .setMenuActionSheetItems(sheetItems)
                                    .build()
                            DCUniMPSDK.getInstance().initialize(this, config)

//                            //监听胶囊点击事件
//                            DCUniMPSDK.getInstance()
//                                    .setCapsuleMenuButtonClickCallBack { appId ->
//                                        val backdata = JSONObject().apply {
//                                            set("appId", appId)
//                                            set("event", "capsuleaction")
//                                        }
//                                        eventSink?.success(backdata)
//                                    }

//                            // 监听小程序关闭
//                            DCUniMPSDK.getInstance().setUniMPOnCloseCallBack { appId ->
//                                if (unimpMap.containsKey(appId)) {
//                                    unimpMap.remove(appId)
//                                    unimpMap[appId]?.closeUniMP();
//                                }
//                                val backdata = JSONObject().apply {
//                                    set("appId", appId)
//                                    set("event", "close")
//                                }
//                                eventSink?.success(backdata)
//                            }

                            //监听小程序向原生发送事件回调方法
                            DCUniMPSDK.getInstance()
                                    .setOnUniMPEventCallBack { appId, event, data, callback ->
                                        val backdata = JSONObject().apply {
                                            set("appId", appId)
                                            set("event", event)
                                            set("data", data)
                                        }
                                        eventSink?.success(backdata)
                                        uniMpcallback = callback
                                    }

                            res.success(true)
                        }
                    } catch (e: Exception) {
                        e.printStackTrace()
                        res.error("error_code", e.message, e.printStackTrace().toString())
                    }
                }

                /** 获取指定的 UniMP 小程序版本
                 * {
                 *      "appId": ""
                 * }
                 */
                "versionMP" -> {
                    var name = "0.0.0"
                    var code = 0
                    try {
                        // 接收 Flutter 传入的参数
                        val appId: String? = call.argument<String>("appId")
                        if (DCUniMPSDK.getInstance().isExistsApp(appId)) {
                        var    jsonObject = DCUniMPSDK.getInstance().getAppVersionInfo(appId)
                            name = jsonObject.getString("name")
                            code = jsonObject.getInt("code")
                        }
                    } catch (e: Exception) {
                        e.printStackTrace()
                    } finally {
                        val version = mutableMapOf<String, Any>()
                        version["name"] = name
                        version["code"] = code
                        res.success(version)
                    }
                }

                /** 安装 UniMP 小程序
                 * {
                 *      "appId": ""，
                 *      "wgtPath": ""
                 * }
                 */
                "installMP" -> {
                    try {
                        // 接收 Flutter 传入的参数
                        val appId: String? = call.argument<String>("appId")
                        val wgtPath: String? = call.argument<String>("wgtPath")
                        val releaseConfig = UniMPReleaseConfiguration()
                        releaseConfig.wgtPath = wgtPath
                        DCUniMPSDK.getInstance().releaseWgtToRunPath(
                                appId,
                                releaseConfig
                        ) { code, result ->
                            if (code == 1) {
                                res.success(true)
                            } else {
                                res.success(false)
                            }
                        }
                    } catch (e: Exception) {
                        e.printStackTrace()
                        res.error("error_code", e.message, e.printStackTrace().toString())
                    }
                }

                /** 打开指定的 UniMP 小程序
                 * {
                 *      "appId": "",
                 *      "isreload": true //重新打开
                 *      "config": {
                 *          "extraData": {},  //其他自定义参数JSON
                 *          "path": "" //指定启动应用后直接打开的页面路径
                 *      }
                 * }
                 */
                "openMP" -> {
                    try {
                        // 接收 Flutter 传入的参数
                        val appId: String? = call.argument<String>("appId")
                        if (unimpMap.containsKey(appId) == false) {
                            val argumentConfig: HashMap<String,Any>? = call.argument<HashMap<String,Any>>("config")
                            val uniMPOpenConfiguration = UniMPOpenConfiguration()
                            if (argumentConfig != null && argumentConfig.containsKey("extraData")) {
                                val jsonObject = org.json.JSONObject()
                                var extraData = argumentConfig.get("extraData") as HashMap<String,Any>
                                extraData.forEach { (s, any) ->  jsonObject.put(s,any) }
                                jsonObject.put("path",argumentConfig.get("path") as String?)
                                uniMPOpenConfiguration.extraData = jsonObject
                            }
                            if (argumentConfig != null && argumentConfig.containsKey("path")) {
                                uniMPOpenConfiguration.path = argumentConfig.get("path") as String?
                            }
                            // 打开小程序
                            unimpMap[appId] = DCUniMPSDK.getInstance()
                                    .openUniMP(applicationContext, appId, uniMPOpenConfiguration)
                            res.success(true)
                        } else {
                            val data = call.argument<Any>("config")
                            val backdata = JSONObject().apply {
                                set("appId", appId)
                                set("data", data)
                            }
                            unimpMap[appId]?.sendUniMPEvent("open_app", backdata)
                            unimpMap[appId]?.showUniMP();
                            res.success(true)
                        }
                    } catch (e: Exception) {
                        e.printStackTrace()
                        res.error("error_code", e.message, e.printStackTrace().toString())
                    }
                }

                /** 隐藏指定的 UniMP 小程序
                 * {
                 *      "appId": "",
                 * }
                 */
                "hideMP" -> {
                    try {
                        // 接收 Flutter 传入的参数
                        val appId: String? = call.argument<String>("appId")
                        if (unimpMap.containsKey(appId)) {
                            unimpMap[appId]?.hideUniMP();
                        }
                        res.success(true)
                    } catch (e: Exception) {
                        e.printStackTrace()
                        res.error("error_code", e.message, e.printStackTrace().toString())
                    }
                }

                /** 关闭指定的 UniMP 小程序
                 * {
                 *      "appId": "",
                 * }
                 */
                "closeMP" -> {
                    try {
                        // 接收 Flutter 传入的参数
                        val appId: String? = call.argument<String>("appId")
                        if (unimpMap.containsKey(appId)) {
                            unimpMap[appId]?.closeUniMP();
                            unimpMap.remove(appId)
                        }
                        res.success(true)
                    } catch (e: Exception) {
                        e.printStackTrace()
                        res.error("error_code", e.message, e.printStackTrace().toString())
                    }
                }

                /**发送数据到指定的UniMP小程序
                 * {
                 *      "appId": "",
                 *      "event": "",
                 *      "data": {}
                 * }
                 */
                "sendMP" -> {
                    try {
                        // 接收 Flutter 传入的参数
                        val appId = call.argument<String>("appId")
                        val sendEvent = call.argument<String>("event")
                        val data = call.argument<Any>("data")

                        val backdata = JSONObject().apply {
                            set("appId", appId)
                            set("event", sendEvent)
                            set("data", data)
                        }
                        unimpMap[appId]?.sendUniMPEvent(sendEvent, backdata)
                        res.success(true)
                    } catch (e: Exception) {
                        e.printStackTrace()
                        res.error("error_code", e.message, e.printStackTrace().toString())
                    }
                }

                /** 回调数据到到指定的UniMP小程序
                 * {
                 *      "appId": "",
                 *      "event": "",
                 *      "data": {}
                 * }
                 */
                "callbackMP" -> {
                    try {
                        // 接收 Flutter 传入的参数
                        val appId = call.argument<String>("appId")
                        val sendEvent = call.argument<String>("event")
                        val data = call.argument<Any>("data")

                        val backdata = JSONObject().apply {
                            set("appId", appId)
                            set("event", sendEvent)
                            set("data", data)
                        }
                        uniMpcallback?.invoke(backdata)
                        res.success(true)
                    } catch (e: Exception) {
                        e.printStackTrace()
                        res.error("error_code", e.message, e.printStackTrace().toString())
                    }
                }



                else -> {
                    // 如果有未识别的方法名，通知执行失败
                    res.error("error_code", "error_message", null)
                }
            }
        }
    }
}
