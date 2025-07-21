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
          break;
        case CallStatus.reject:
          break;
        case CallStatus.connect:
          break;
        default:
          return;
      }
      // 返回
      if (!_back) {
        Get.back();
      }
      // 提醒
      EasyLoading.showToast(status.label);
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
    if (mounted) {
      audioPlayer.stop();
      _subscription.cancel();
      _timer?.cancel();
    }
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
  bool _speakerOn = false; // 新增：免提状态（默认关闭）

  @override
  void initState() {
    super.initState();
    AppConfig.callKit = widget.chatId;
    initializeCalling();
  }

  @override
  void dispose() {
    _engine?.leaveChannel();
    AppConfig.callKit = '';
    super.dispose();
  }

  Future<void> initializeCalling() async {
    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    // 视频
    if (widget.video) {
      var configuration = const VideoEncoderConfiguration(
        dimensions: VideoDimensions(
          width: 1920,
          height: 1080,
        ),
        orientationMode: OrientationMode.orientationModeAdaptive,
      );
      await _engine?.setVideoEncoderConfiguration(configuration);
    }
    // 语音
    else {
      await _engine?.setDefaultAudioRouteToSpeakerphone(true);
    }
    await _engine?.joinChannel(
      token: widget.token,
      channelId: widget.channel,
      uid: int.parse(ToolsStorage().local().userNo),
      options: const ChannelMediaOptions(),
    );
  }

  // 初始化
  Future<void> _initAgoraRtcEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine?.initialize(
      RtcEngineContext(
        appId: ToolsStorage().config().callKit,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );
    // 视频
    if (widget.video) {
      await _engine?.enableVideo();
    }
    // 语音
    else {
      await _engine?.enableAudio();
    }
  }

  // 免提开关（新增方法）
  void _onToggleSpeaker() {
    setState(() {
      _speakerOn = !_speakerOn;
    });
    // 通过Agora引擎切换音频路由（扬声器/听筒）
    _engine?.setDefaultAudioRouteToSpeakerphone(_speakerOn);
  }

  // 摄像头反转
  _onToggleCamera() {
    _engine?.switchCamera().then((value) {
      setState(() {
        _mutedFront = !_mutedFront;
      });
    });
  }

  // 语音开关
  void _onToggleMuteAudio() {
    setState(() {
      _mutedAudio = !_mutedAudio;
    });
    _engine?.muteLocalAudioStream(_mutedAudio);
  }

  // 视频开关
  void _onToggleMuteVideo() {
    setState(() {
      _mutedVideo = !_mutedVideo;
    });
    _engine?.muteLocalVideoStream(_mutedVideo);
  }

  // 监听通道
  void _addAgoraEventHandlers() {
    _engine?.registerEventHandler(RtcEngineEventHandler(
      // 好友加入
      onUserJoined: (connection, remote, elapsed) {
        if (mounted) {
          setState(() {
            _remote = remote;
          });
        }
      },
      // 好友离开
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
        // 返回
        if ('/ToolsCallVideo' == Get.currentRoute) {
          Get.back();
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
                //_cancelView(),
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

  // 自己的窗口
  _localVideo() {
    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: _engine!,
        canvas: const VideoCanvas(uid: 0),
      ),
    );
  }

  // 朋友的窗口
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

  // 计时器
  _timerView() {
    return Positioned(
      top: 45,
      left: 0,
      right: 0,
      child: Center(
        child: Opacity(
          opacity: 1,
          child: ToolsTimerView(
            onChange: (int second) {
              _second = second;
            },
          ),
        ),
      ),
    );
  }

  // 本地摄像头
  _cameraView() {
    return Container(
      padding: const EdgeInsets.only(top: 75.0, right: 20.0),
      alignment: Alignment.topRight,
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

  // 底部按钮
  _bottomView() {
    return Container(
      margin: const EdgeInsets.all(20.0),
      alignment: Alignment.bottomCenter,
      child: widget.video
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 第一行：麦克风、免提
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 麦克风开关按钮（带文字）
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
                    // 免提按钮
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
                const SizedBox(height: 20), // 两行之间的间距
                // 第二行：摄像头、挂断、摄像头翻转
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 视频开关按钮（带文字）
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RawMaterialButton(
                          onPressed: _onToggleMuteVideo,
                          elevation: 2.0,
                          padding: const EdgeInsets.all(15.0),
                          shape: const CircleBorder(),
                          // 修改这里，使用 _mutedVideo 状态来设置颜色
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
                    // 挂断按钮
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
                            Get.back();
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
                    // 摄像头翻转按钮（带文字）
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
                // 麦克风开关按钮（带文字）
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
                // 挂断按钮
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
                        Get.back();
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
                // 免提按钮
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

  // 关闭按钮
  _cancelView() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 40, right: 25),
        child: InkWell(
          onTap: () {
            Get.back();
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

  // 头像
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

// 时间计时器
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
    if (_timer != null) {
      _timer?.cancel();
    }
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
