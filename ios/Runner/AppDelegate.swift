import Flutter
import UIKit
import AVFoundation

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
    private func wakeUpApp(_ callData: [String: String]?) {
        // 1. 激活应用到前台（原逻辑保留，优化URL Scheme判断）
        guard let url = URL(string: "yourappscheme://") else {
            print("唤醒失败：URL Scheme 无效")
            return
        }
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.removeAllPendingNotificationRequests()
            UIApplication.shared.open(url, options: [:]) { [weak self] success in
                if success {
                    print("应用唤醒成功")
                    // 唤醒成功后，触发全屏配置
                    self?.enableFullScreenForRootVC()
                    // 唤醒后重新激活音频会话
                    // 延迟重置音频会话，确保应用完全激活
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self?.resetAudioSession()
                    }
                }
            }
        } else {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
                // 唤醒成功后，触发全屏配置
                enableFullScreenForRootVC()
                // 唤醒后重新激活音频会话
                self.resetAudioSession()
            }
        }
        
        // 2. 处理通话数据（原逻辑保留）
        if let data = callData {
            print("收到通话数据: \(data)")
            // （可选）若需传递数据到Flutter，可通过MethodChannel发送
        }
    }

    /// 让根视图控制器（FlutterViewController）实现全屏
    private func enableFullScreenForRootVC() {
        // 1. 获取当前根视图控制器（确保是FlutterViewController）
        guard let rootVC = window?.rootViewController as? FlutterViewController else {
            print("全屏配置失败：根视图控制器不是FlutterViewController")
            return
        }
        
        // 2. 隐藏状态栏（主动触发状态栏刷新）
        rootVC.setNeedsStatusBarAppearanceUpdate() // 强制刷新状态栏配置
        
        // 3. 移除安全区边距（适配刘海屏，实现真正全屏）
        // 给FlutterViewController添加全屏约束，忽略安全区
        rootVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rootVC.view.topAnchor.constraint(equalTo: window!.topAnchor),    // 顶部贴屏幕顶
            rootVC.view.leadingAnchor.constraint(equalTo: window!.leadingAnchor), // 左侧贴屏幕左
            rootVC.view.trailingAnchor.constraint(equalTo: window!.trailingAnchor), // 右侧贴屏幕右
            rootVC.view.bottomAnchor.constraint(equalTo: window!.bottomAnchor)     // 底部贴屏幕底
        ])

        // 重置音频会话配置
        resetAudioSession()
        
        // 4. （可选）强制Flutter视图刷新（避免Flutter侧未适配安全区）
        // 通过MethodChannel通知Flutter侧进入全屏模式，让Flutter页面也适配
        let channel = FlutterMethodChannel(name: "flutter_uni_channel", binaryMessenger: rootVC.binaryMessenger)
        channel.invokeMethod("onFullScreenActivated", arguments: ["isFullScreen": true])
    }

    // 新增音频会话重置方法
    private func resetAudioSession() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            // 先尝试停用当前会话
            try audioSession.setActive(false, options: .notifyOthersOnDeactivation)
            
            // 根据实际使用场景调整类别（如果主要是播放，可用.playback）
            try audioSession.setCategory(
                .playAndRecord,
                mode: .default,
                options: [.mixWithOthers, .allowBluetooth, .allowAirPlay]
            )
            
            // 延迟激活，避免状态冲突
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                do {
                    try audioSession.setActive(true)
                    print("音频会话激活成功")
                } catch {
                    print("音频会话激活失败: \(error.localizedDescription)")
                    print("错误代码: \(error._code)")
                }
            }
        } catch {
            print("音频会话配置失败: \(error.localizedDescription)")
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
    // 在文件末尾添加扩展，让FlutterViewController响应状态栏隐藏
}
// 修复扩展中的属性重写问题
extension FlutterViewController {
    // 1. 增加open访问控制符，与父类保持一致
    override open var prefersStatusBarHidden: Bool {
        return true
    }
        
    // 2. 将public改为open，与父类UIViewController的viewWillAppear访问级别匹配
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}