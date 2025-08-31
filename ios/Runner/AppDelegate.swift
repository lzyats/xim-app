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
    // 后台任务ID
    var backgroundTaskId: UIBackgroundTaskIdentifier = .invalid

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        /// 是否初始化
        var isInit = false
        
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "flutter_uni_channel", binaryMessenger: controller.binaryMessenger)
        let event = FlutterEventChannel(name: "flutter_uni_stream", binaryMessenger: controller.binaryMessenger)
        let backgroundChannel = FlutterMethodChannel(name: "lansoft.com/background_task", binaryMessenger: controller.binaryMessenger)
        event.setStreamHandler(self)

        
        // 注册唤醒通道
        // 注册通道
        let wakeupChannel = FlutterMethodChannel(name: "lansoft.com/wakeup", binaryMessenger: controller.binaryMessenger)
        // 实现wakeUp方法
        wakeupChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
        if call.method == "wakeUp" {
            self?.wakeUpApp(call.arguments as? [String: String])
            result(nil)
        } else {
            result(FlutterMethodNotImplemented)
        }
        }

        // 2. 处理后台任务调用
        backgroundChannel.setMethodCallHandler { [weak self] (call, result) in
        guard let self = self else { return }
        switch call.method {
        case "startBackgroundTask":
            // 启动后台任务
            self.backgroundTaskId = application.beginBackgroundTask {
            // 后台任务超时回调：结束任务避免系统杀死应用
            application.endBackgroundTask(self.backgroundTaskId)
            self.backgroundTaskId = .invalid
            }
            result(self.backgroundTaskId.rawValue) // 返回任务ID给Dart
            
        case "endBackgroundTask":
            // 结束后台任务
            if let taskId = call.arguments as? Int {
            let bgTaskId = UIBackgroundTaskIdentifier(rawValue: taskId)
            if bgTaskId != .invalid {
                application.endBackgroundTask(bgTaskId)
                self.backgroundTaskId = .invalid
            }
            }
            result(nil)
            
        default:
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
     // 唤醒应用的具体实现
    // 替换原来的 wakeUpApp 方法
    private func wakeUpApp(_ callData: [String: String]?) {
        // 确保应用在前台
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.removeAllPendingNotificationRequests()
            // iOS 10+ 正确的激活应用方式
            UIApplication.shared.open(URL(string: "yourappscheme://")!, options: [:], completionHandler: nil)
        } else {
            // 兼容旧版本iOS
            UIApplication.shared.openURL(URL(string: "yourappscheme://")!)
        }
        
        // 处理通话数据
        if let data = callData {
            print("收到通话数据: \(data)")
            // 保存通话参数供后续使用
        }
    }

    // 配置视图控制器全屏（在 FlutterViewController 中）
    var prefersStatusBarHidden: Bool {
        return true // 隐藏状态栏，实现全屏
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