import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/config/app_resource.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/request/request_message.dart';
import 'package:alpaca/tools/tools_badger.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_perms.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:alpaca/tools/tools_storage.dart';

// 音视频
class ToolsCall extends StatefulWidget {
  final String portrait;
  final String nickname;
  final bool video;
  final bool request;
  final String channel;
  final String token;
  final String chatId;
  const ToolsCall({
    super.key,
    required this.portrait,
    required this.nickname,
    required this.video,
    required this.channel,
    this.request = false,
    this.token = '',
    this.chatId = '',
  });
  @override
  createState() => _ToolsCallState();
}

class _ToolsCallState extends State<ToolsCall> {
  String channel = '';
  String token = '';
  Timer? _timer;
  bool _trigger = false;
  bool _back = false;
  String value = '';
  final AudioPlayer audioPlayer = AudioPlayer();
  late StreamSubscription _subscription;
  @override
  void initState() {
    super.initState();
    // 赋值
    token = widget.token;
    channel = widget.channel;
    _trigger = widget.request;
    AppConfig.callKit = widget.chatId;
    // 初始化
    _initSetting();
    // 监听关闭
    _subscription = EventSetting().event.stream.listen((model) {
      if (SettingType.sys != model.setting) {
        return;
      }
      if ('call' != model.label) {
        return;
      }
      if (channel != model.primary) {
        return;
      }
      if (value == model.value) {
        return;
      }
      value = model.value;
      // 转换
      Map<String, dynamic> content = jsonDecode(model.value);
      CallStatus status = CallStatus.init(content['callStatus']);
      if (_trigger && CallStatus.connect == status) {
        _startCall(false);
        return;
      }
      switch (status) {
        case CallStatus.cancel:
        case CallStatus.reject:
        case CallStatus.finish:
          // 处理通话终止状态
          if (!_back) {
            Get.back();
          }
          EasyLoading.showToast(status.label);
          break;
        default:
          return;
      }
    });
  }

  // 初始化
  _initSetting() async {
    // 声音消息
    AudioSource audioSource = AudioSource.asset(AppAudio.call);
    await audioPlayer.setAudioSource(audioSource);
    audioPlayer.setLoopMode(LoopMode.all);
    audioPlayer.play();
    _timer = Timer(
      const Duration(milliseconds: 60 * 1000),
      _endCall,
    );
  }

  @override
  void dispose() {
    audioPlayer.stop();
    _subscription.cancel();
    _timer?.cancel();
    AppConfig.callKit = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 多重渐变背景
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF808080), // 浅灰色
              Color(0xFF404040), // 深灰色
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildPortrait(),
            Text(
              widget.video ? '视频通话' : '语音通话',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _callingButton(false),
                SizedBox(width: widget.request ? 0 : 100),
                _callingButton(true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 头像
  _buildPortrait() {
    return Column(
      children: [
        WidgetCommon.showAvatar(widget.portrait, size: 100, yj: 55),
        const SizedBox(
          height: 20,
        ),
        Text(
          widget.nickname,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  // 按钮
  _callingButton(bool isCall) {
    if (isCall && widget.request) {
      return Container();
    }
    return Column(
      children: [
        RawMaterialButton(
          onPressed: () {
            if (isCall) {
              _startCall(isCall);
              // 计数器
              ToolsBadger().subtraction(widget.chatId);
            } else {
              _endCall(auto: false);
            }
          },
          shape: const CircleBorder(),
          elevation: 2.0,
          fillColor: isCall ? Colors.green : Colors.redAccent,
          padding: const EdgeInsets.all(15.0),
          child: Icon(
            isCall ? Icons.call : Icons.call_end,
            color: Colors.white,
            size: 35.0,
          ),
        ),
        const SizedBox(height: 8),
        if (!isCall)
          Text(
            '挂断',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
          ),
        if (isCall)
          Text(
            '接听',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
          ),
      ],
    );
  }

  // 接听
  void _startCall(bool isCall) async {
    // 触发
    if (isCall) {
      // 权限
      bool result = await ToolsPerms.microphone();
      if (!result) {
        return;
      }
      if (widget.video) {
        // 权限
        result = await ToolsPerms.camera();
        if (!result) {
          return;
        }
      }
      // 请求
      token = await RequestMessage.callKit(channel, CallStatus.connect);
      // 设置
      _trigger = true;
    }
    // 取消倒计时
    _timer?.cancel();
    // 取消响铃
    audioPlayer.stop();
    // 跳转
    ToolsCallVideo _toolsCallVideo = ToolsCallVideo(
      portrait: widget.portrait,
      nickname: widget.nickname,
      video: widget.video,
      channel: channel,
      token: token,
      chatId: widget.chatId,
    );
    // 发起者
    if (widget.request) {
      Get.off(_toolsCallVideo);
    }
    // 接收者
    else {
      Get.to(_toolsCallVideo);
    }
  }

  // 挂断
  _endCall({bool auto = true}) async {
    // 返回
    Get.back();
    // 判断
    if (widget.request) {
      // 请求
      RequestMessage.callKit(channel, CallStatus.cancel);
      // 提醒
      EasyLoading.showToast(auto ? '无人接听' : '取消通话');
    } else if (!auto) {
      // 请求
      RequestMessage.callKit(channel, CallStatus.reject);
      // 提醒
      EasyLoading.showToast('拒绝通话');
      // 计数器
      ToolsBadger().subtraction(widget.chatId);
    }
    _back = true;
  }
}

class ToolsCallVideo extends StatefulWidget {
  final bool video;
  final String portrait;
  final String nickname;
  final String channel;
  final String token;
  final String chatId;

  const ToolsCallVideo({
    super.key,
    required this.video,
    required this.portrait,
    required this.nickname,
    required this.channel,
    required this.token,
    required this.chatId,
  });

  @override
  createState() => _ToolsCallVideoState();
}

class _ToolsCallVideoState extends State<ToolsCallVideo> {
  int? _remote;
  bool _switch = false;
  RtcEngine? _engine;
  bool _mutedFront = false;
  bool _mutedAudio = false;
  bool _mutedVideo = false;
  int _second = 0;
  bool _speakerOn = false;
  late StreamSubscription _callEventSubscription;

  @override
  void initState() {
    super.initState();
    AppConfig.callKit = widget.chatId;
    initializeCalling();
    _setupCallEventListening();
  }

  @override
  void dispose() {
    _engine?.leaveChannel();
    _callEventSubscription.cancel();
    AppConfig.callKit = '';
    super.dispose();
  }

  void _setupCallEventListening() {
    _callEventSubscription = EventSetting().event.stream.listen((model) {
      if (SettingType.sys != model.setting || 'call' != model.label) {
        return;
      }
      if (widget.channel != model.primary) {
        return;
      }

      try {
        Map<String, dynamic> content = jsonDecode(model.value);
        CallStatus status = CallStatus.init(content['callStatus']);

        if (status == CallStatus.cancel ||
            status == CallStatus.reject ||
            status == CallStatus.finish) {
          if (mounted) {
            Get.until((route) => !Get.currentRoute.contains('ToolsCall'));
          }
        }
      } catch (e) {
        debugPrint('解析通话事件失败: $e');
      }
    });
  }

  // 在 _initAgoraRtcEngine 方法中初始化音频路由，确保在引擎初始化后立即设置
  Future<void> _initAgoraRtcEngine() async {
    _engine = createAgoraRtcEngine();
    // 1. 先初始化引擎
    await _engine?.initialize(
      RtcEngineContext(
        appId: ToolsStorage().config().callKit,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );

    // 2. 初始化后立即设置音频路由（关键优化）
    if (!widget.video) {
      // 语音通话：默认使用听筒
      _speakerOn = false;
      await _engine?.setEnableSpeakerphone(false); // 先禁用扬声器
      await _engine?.setDefaultAudioRouteToSpeakerphone(false); // 路由到听筒
    } else {
      // 视频通话：默认使用扬声器
      _speakerOn = true;
      await _engine?.setEnableSpeakerphone(true); // 先启用扬声器
      await _engine?.setDefaultAudioRouteToSpeakerphone(true); // 路由到扬声器
    }

    // 3. 最后启用音视频（确保路由设置在音视频启用前完成）
    if (widget.video) {
      await _engine?.enableVideo();
    } else {
      await _engine?.enableAudio();
    }
  }

  // 修改 initializeCalling 方法，移除重复的音频设置
  Future<void> initializeCalling() async {
    await _initAgoraRtcEngine(); // 已在引擎初始化时设置音频路由
    _addAgoraEventHandlers();

    if (widget.video) {
      var configuration = const VideoEncoderConfiguration(
        dimensions: VideoDimensions(width: 1920, height: 1080),
        orientationMode: OrientationMode.orientationModeAdaptive,
      );
      await _engine?.setVideoEncoderConfiguration(configuration);
    }

    // 加入频道（此时音频路由已正确设置）
    await _engine?.joinChannel(
      token: widget.token,
      channelId: widget.channel,
      uid: int.parse(ToolsStorage().local().userNo),
      options: const ChannelMediaOptions(),
    );
  }

// 优化免提切换方法，增加异常捕获和状态同步
  void _onToggleSpeaker() {
    setState(() => _speakerOn = !_speakerOn);
    if (_engine != null) {
      // 确保两个方法的参数一致
      _engine?.setEnableSpeakerphone(_speakerOn).then((_) {
        return _engine?.setDefaultAudioRouteToSpeakerphone(_speakerOn);
      }).catchError((error) {
        // 捕获异常并回滚状态
        setState(() => _speakerOn = !_speakerOn);
        debugPrint("免提切换失败: $error");
        EasyLoading.showToast("免提切换失败，请重试");
      });
    }
  }

  _onToggleCamera() {
    _engine?.switchCamera().then((value) {
      setState(() {
        _mutedFront = !_mutedFront;
      });
    });
  }

  void _onToggleMuteAudio() {
    setState(() {
      _mutedAudio = !_mutedAudio;
    });
    _engine?.muteLocalAudioStream(_mutedAudio);
  }

  void _onToggleMuteVideo() {
    setState(() {
      _mutedVideo = !_mutedVideo;
    });
    _engine?.muteLocalVideoStream(_mutedVideo);
  }

  void _addAgoraEventHandlers() {
    _engine?.registerEventHandler(RtcEngineEventHandler(
      onUserJoined: (connection, remote, elapsed) {
        if (mounted) {
          setState(() {
            _remote = remote;
          });
        }
      },
      onUserOffline: (connection, int remote, UserOfflineReasonType reason) {
        if (mounted) {
          setState(() {
            _remote = null;
          });
        }
        RequestMessage.callKit(
          widget.channel,
          CallStatus.finish,
          second: _second,
        );
        if (mounted && Get.currentRoute.contains('ToolsCallVideo')) {
          Get.until((route) => !Get.currentRoute.contains('ToolsCall'));
        }
      },
      onLeaveChannel: (connection, stats) {
        if (mounted) {
          Get.until((route) => !Get.currentRoute.contains('ToolsCall'));
        }
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: widget.video
            ? [
                Center(
                  child: _switch ? _localVideo() : _remoteVideo(),
                ),
                _timerView(),
                _cancelView(),
                _cameraView(),
                _bottomView(),
              ]
            : [
                Center(
                  child: _buildPortrait(),
                ),
                _timerView(),
                _cancelView(),
                _bottomView(),
              ],
      ),
    );
  }

  _localVideo() {
    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: _engine!,
        canvas: const VideoCanvas(uid: 0),
      ),
    );
  }

  _remoteVideo() {
    if (_remote != null) {
      return Stack(
        children: [
          AgoraVideoView(
            controller: VideoViewController.remote(
              rtcEngine: _engine!,
              canvas: VideoCanvas(uid: _remote),
              connection: RtcConnection(channelId: widget.channel),
            ),
          ),
        ],
      );
    }
    return Container();
  }

  _timerView() {
    return Positioned(
      top: 45,
      left: 25.0,
      child: Opacity(
        opacity: 1,
        child: ToolsTimerView(
          onChange: (int second) {
            _second = second;
          },
        ),
      ),
    );
  }

  _cameraView() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 75.0, horizontal: 20.0),
      alignment: Alignment.bottomRight,
      child: FractionallySizedBox(
        child: Container(
          width: 110.0,
          height: 139.0,
          alignment: Alignment.topRight,
          color: Colors.black,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _switch = !_switch;
              });
            },
            child: Center(
              child: _switch ? _remoteVideo() : _localVideo(),
            ),
          ),
        ),
      ),
    );
  }

  _bottomView() {
    return Container(
      margin: const EdgeInsets.all(20.0),
      alignment: Alignment.bottomCenter,
      child: widget.video
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RawMaterialButton(
                          onPressed: _onToggleMuteAudio,
                          elevation: 2.0,
                          fillColor:
                              _mutedAudio ? Colors.grey : Color(0xFF4E4E4E),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(7.5),
                          child: Icon(
                            _mutedAudio ? Icons.mic_off : Icons.mic,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _mutedAudio ? "关闭麦克风" : "开启麦克风",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RawMaterialButton(
                          onPressed: _onToggleSpeaker,
                          elevation: 2.0,
                          fillColor: _speakerOn
                              ? Colors.blue
                              : const Color(0xFF4E4E4E),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(7.5),
                          child: Icon(
                            _speakerOn ? Icons.volume_up : Icons.volume_down,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _speakerOn ? "关闭免提" : "开启免提",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RawMaterialButton(
                          onPressed: _onToggleMuteVideo,
                          elevation: 2.0,
                          padding: const EdgeInsets.all(15.0),
                          shape: const CircleBorder(),
                          fillColor: _mutedVideo
                              ? Colors.grey
                              : const Color(0xFF4E4E4E),
                          child: Icon(
                            _mutedVideo ? Icons.videocam_off : Icons.videocam,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _mutedVideo ? "摄像头已关" : "摄像头已开",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RawMaterialButton(
                          onPressed: () {
                            _engine?.leaveChannel();
                            RequestMessage.callKit(
                              widget.channel,
                              CallStatus.finish,
                              second: _second,
                            );
                            Get.until((route) =>
                                !Get.currentRoute.contains('ToolsCall'));
                          },
                          elevation: 2.0,
                          fillColor: Colors.redAccent,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(15.0),
                          child: const Icon(
                            Icons.call_end,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "挂断",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RawMaterialButton(
                          onPressed: _onToggleCamera,
                          elevation: 2.0,
                          fillColor: const Color(0xFF4E4E4E),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(15.0),
                          child: const Icon(
                            Icons.cached,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "切换摄像头",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RawMaterialButton(
                      onPressed: _onToggleMuteAudio,
                      elevation: 2.0,
                      fillColor: _mutedAudio ? Colors.grey : Color(0xFF4E4E4E),
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(15.0),
                      child: Icon(
                        _mutedAudio ? Icons.mic_off : Icons.mic,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _mutedAudio ? "关闭麦克风" : "开启麦克风",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RawMaterialButton(
                      onPressed: () {
                        _engine?.leaveChannel();
                        RequestMessage.callKit(
                          widget.channel,
                          CallStatus.finish,
                          second: _second,
                        );
                        Get.until(
                            (route) => !Get.currentRoute.contains('ToolsCall'));
                      },
                      elevation: 2.0,
                      fillColor: Colors.redAccent,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(15.0),
                      child: const Icon(
                        Icons.call_end,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "挂断",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RawMaterialButton(
                      onPressed: _onToggleSpeaker,
                      elevation: 2.0,
                      fillColor:
                          _speakerOn ? Colors.blue : const Color(0xFF4E4E4E),
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(15.0),
                      child: Icon(
                        _speakerOn ? Icons.volume_up : Icons.volume_down,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _speakerOn ? "关闭免提" : "开启免提",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  _cancelView() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 40, right: 25),
        child: InkWell(
          onTap: () {
            _engine?.leaveChannel();
            RequestMessage.callKit(
              widget.channel,
              CallStatus.finish,
              second: _second,
            );
            Get.until((route) => !Get.currentRoute.contains('ToolsCall'));
          },
          child: const Icon(
            Icons.cancel,
            color: Colors.white,
            size: 35,
          ),
        ),
      ),
    );
  }

  _buildPortrait() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WidgetCommon.showAvatar(
          widget.portrait,
          size: 100,
        ),
        const SizedBox(height: 20),
        Text(
          widget.nickname,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

class ToolsTimerView extends StatefulWidget {
  final Function(int second) onChange;
  const ToolsTimerView({
    super.key,
    required this.onChange,
  });

  @override
  createState() => ToolsTimerViewState();
}

class ToolsTimerViewState extends State<ToolsTimerView> {
  Timer? _timer;
  int _second = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _second++;
      });
      widget.onChange(_second);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatDuration(Duration(seconds: _second)),
      style: const TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

_formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  var twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  var twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  if (duration.inHours > 0) {
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
  return "$twoDigitMinutes:$twoDigitSeconds";
}
