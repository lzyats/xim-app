import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, DCUniMPSDKEngineDelegate, FlutterStreamHandler {
    /// 小程序打开Map
    var uniMpMap: [String: DCUniMPInstance] = [:]
    /// 监听sink
    var eventSink: FlutterEventSink?
    /// 回调函数
    var uniMpCallback: DCUniMPKeepAliveCallback?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        /// 是否初始化
        var isInit = false
        
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "flutter_uni_channel", binaryMessenger: controller.binaryMessenger)
        let event = FlutterEventChannel(name: "flutter_uni_stream", binaryMessenger: controller.binaryMessenger)
        event.setStreamHandler(self)

        // 注册浮窗通道
        let overlayChannel = FlutterMethodChannel(name: "vip.myim/overlay", binaryMessenger: controller.binaryMessenger)
        overlayChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            switch call.method {
            case "requestOverlayPermission":
                // iOS需要请求相应权限
                result(true)
            case "showCallOverlay":
                if let args = call.arguments as? [String: Any],
                   let eventData = args["eventData"] as? String {
                    self?.showCallOverlay(eventData: eventData)
                    result(true)
                } else {
                    result(false)
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        
        // 注册唤醒通道
        let wakeupChannel = FlutterMethodChannel(name: "vip.myim/wakeup", binaryMessenger: controller.binaryMessenger)
        wakeupChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "wakeUp" {
                self?.wakeUpApp()
                result(true)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        // 设置主通道的方法处理器
        channel.setMethodCallHandler({ [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch(call.method) {
            case "initMP":
                if isInit {
                    result(isInit)
                } else {
                    let options = NSMutableDictionary.init(dictionary: launchOptions ?? [:])
                    options.setValue(NSNumber.init(value: true), forKey: "debug")
                    DCUniMPSDKEngine.setDelegate(self!)
                    DCUniMPSDKEngine.initSDKEnvironment(launchOptions: options as! [AnyHashable : Any])
                    DCUniMPSDKEngine.setCapsuleButtonHidden(false)
                    isInit = true
                    result(isInit)
                }
                break
            case "versionMP":
                if let arguments = call.arguments as? Dictionary<String, Any> {
                    let appId: String = arguments["appId"] as? String ?? ""
                    if(DCUniMPSDKEngine.isExistsUniMP(appId)){
                        result(DCUniMPSDKEngine.getUniMPVersionInfo(withAppid: appId)!)
                    } else {
                        result(["name": "0.0.0", "code": 0])
                    }
                }
                result(["name": "0.0.0", "code": 0])
                break
            case "installMP":
                if let arguments = call.arguments as? Dictionary<String, Any> {
                    let appId: String = arguments["appId"] as? String ?? ""
                    let wgtPath: String = arguments["wgtPath"] as? String ?? ""
                    do {
                        try DCUniMPSDKEngine.installUniMPResource(withAppid: appId, resourceFilePath: wgtPath, password: nil)
                        result(true)
                    } catch {
                        result(false)
                    }
                }
                result(false)
                break
            case "openMP":
                if let arguments = call.arguments as? Dictionary<String, Any> {
                    let appId: String = arguments["appId"] as? String ?? ""
                    if(self!.uniMpMap[appId] != nil) {
                        var backdata: [String: Any] = [:]
                        backdata["appId"] = appId
                        backdata["data"] = arguments["config"]
                        self!.uniMpMap[appId]?.sendUniMPEvent("open_app", data: backdata)
                        self!.uniMpMap[appId]?.show {(success, error) in
                            if success {
                                result(true)
                            } else {
                                result(false)
                            }
                        }
                    } else {
                        let data: [String: Any] = (arguments["config"] as? [String: Any])!
                        let configuration = DCUniMPConfiguration.init()
                        configuration.enableBackground = true
                        configuration.enableGestureClose = true
                        if let extraData = data["extraData"] as? [String: Any], let path = data["path"] {
                            var updatedExtraData = extraData
                            updatedExtraData["path"] = path
                            configuration.extraData = updatedExtraData
                        }

                        if let path = data["path"] {
                            configuration.path = path as? String
                        }
                        DCUniMPSDKEngine.openUniMP(appId, configuration: configuration) { instance, error in
                            if instance != nil {
                                self!.uniMpMap[appId] = instance
                                result(true)
                            } else {
                                result(false)
                            }
                        }
                    }
                }
                result(false)
                break
            case "hideMP":
                if let arguments = call.arguments as? Dictionary<String, Any> {
                    let appId: String = arguments["appId"] as? String ?? ""
                    if(self!.uniMpMap[appId] != nil) {
                        self!.uniMpMap[appId]?.hide { (success, error) in
                            if success {
                                result(true)
                            } else {
                                result(false)
                            }
                        }
                    }
                }
                result(true)
                break
            case "closeMP":
                if let arguments = call.arguments as? Dictionary<String, Any> {
                    let appId: String = arguments["appId"] as? String ?? ""
                    if(self!.uniMpMap[appId] != nil) {
                        self!.uniMpMap[appId]?.close { (success, error) in
                            if success {
                                self!.uniMpMap.removeValue(forKey: appId)
                                result(true)
                            } else {
                                result(false)
                            }
                        }
                    }
                }
                result(false)
                break
            case "sendMP":
                if let arguments = call.arguments as? Dictionary<String, Any> {
                    let appId: String = arguments["appId"] as? String ?? ""
                    let event: String = arguments["event"] as? String ?? ""
                    let data: Any = arguments["data"] ?? [:]
                    if(self!.uniMpMap[appId] != nil) {
                        var backdata: [String: Any] = [:]
                        backdata["appId"] = appId
                        backdata["event"] = event
                        backdata["data"] = data
                        self!.uniMpMap[appId]?.sendUniMPEvent(event, data: backdata)
                        result(true)
                    }
                }
                result(false)
                break
            case "callbackMP":
                if let arguments = call.arguments as? Dictionary<String, Any> {
                    let appId: String = arguments["appId"] as? String ?? ""
                    let event: String = arguments["event"] as? String ?? ""
                    let data: Any = arguments["data"] ?? [:]
                    var backdata: [String: Any] = [:]
                    backdata["appId"] = appId
                    backdata["event"] = event
                    backdata["data"] = data
                    if let callback = self?.uniMpCallback {
                        callback(backdata, true)
                    }
                }
                result(false)
                break
            default:
                result(FlutterMethodNotImplemented)
                break
            }
        })
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // 唤醒应用
    private func wakeUpApp() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        // 激活应用到前台
        UIApplication.shared.activate(ignoringSnapshotOnResume: true)
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            rootViewController.setNeedsStatusBarAppearanceUpdate()
        }
    }

    // 配置视图控制器全屏（在 FlutterViewController 中）
    override var prefersStatusBarHidden: Bool {
        return true // 隐藏状态栏，实现全屏
    }
    
    // 显示通话浮窗
    private func showCallOverlay(eventData: String) {
        // 实现iOS浮窗逻辑
    }
  
    /// FlutterStreamHandler监听
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        return nil
    }
  
    /// FlutterStreamHandler监听
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
  
    /// 生命周期
    override func applicationDidBecomeActive(_ application: UIApplication) {
        DCUniMPSDKEngine.applicationDidBecomeActive(application)
    }
  
    override func applicationWillResignActive(_ application: UIApplication) {
        DCUniMPSDKEngine.applicationWillResignActive(application)
    }
  
    override func applicationDidEnterBackground(_ application: UIApplication) {
        DCUniMPSDKEngine.applicationDidEnterBackground(application)
    }
  
    override func applicationWillEnterForeground(_ application: UIApplication) {
        DCUniMPSDKEngine.applicationWillEnterForeground(application)
    }
  
    override func applicationWillTerminate(_ application: UIApplication) {
        DCUniMPSDKEngine.destory()
    }
  
    /// 监听小程序向原生发送事件回调方法
    func onUniMPEventReceive(_ appId: String, event: String, data: Any, callback: @escaping DCUniMPKeepAliveCallback) {
        var backdata: [String: Any] = [:]
        backdata["appId"] = appId
        backdata["event"] = event
        backdata["data"] = data
        eventSink?(backdata)
        uniMpCallback = callback
    }
  
    // /// 监听胶囊点击事件
    // func hookCapsuleMenuButtonClicked(_ appId: String) {
    //   var backdata: [String: Any] = [:]
    //   backdata["appId"] = appId
    //   backdata["event"] = "capsuleaction"
    //   eventSink?(backdata)
    // }
  
    // /// 监听小程序关闭
    // func hookCapsuleCloseButtonClicked(_ appId: String) {
    //   var backdata: [String: Any] = [:]
    //   backdata["appId"] = appId
    //   backdata["event"] = "close"
    //   eventSink?(backdata)
    // }
}