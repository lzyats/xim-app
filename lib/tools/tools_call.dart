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
  final AudioPlayer audioPlayer = AudioPlayer();
  late StreamSubscription _subscription;
  @override
  void initState() {
    super.initState();
    // 赋值
    token = widget.token;
    channel = widget.channel;
    _trigger = widget.request;
    AppConfig.callKit = true;
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
      // 提醒
      EasyLoading.showToast(status.label);
      // 返回
      if (!_back) {
        Get.back();
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
    if (mounted) {
      audioPlayer.stop();
      _subscription.cancel();
      _timer?.cancel();
    }
    AppConfig.callKit = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.6],
            colors: [Color(0xffFF6347), Color(0xff000000)],
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
        WidgetCommon.showAvatar(
          widget.portrait,
          size: 100,
        ),
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
    return RawMaterialButton(
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
    Get.off(
      () => ToolsCallVideo(
        portrait: widget.portrait,
        nickname: widget.nickname,
        video: widget.video,
        channel: channel,
        token: token,
      ),
    );
  }

  // 挂断
  _endCall({bool auto = true}) async {
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
    Get.back();
  }
}

class ToolsCallVideo extends StatefulWidget {
  final bool video;
  final String portrait;
  final String nickname;
  final String channel;
  final String token;

  const ToolsCallVideo({
    super.key,
    required this.video,
    required this.portrait,
    required this.nickname,
    required this.channel,
    required this.token,
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

  @override
  void initState() {
    super.initState();
    AppConfig.callKit = true;
    initializeCalling();
  }

  @override
  void dispose() {
    _engine?.leaveChannel();
    AppConfig.callKit = false;
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
        Get.back();
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

  // 本地摄像头
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

  // 底部按钮
  _bottomView() {
    return Container(
      margin: const EdgeInsets.all(20.0),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (widget.video)
            RawMaterialButton(
              onPressed: _onToggleCamera,
              elevation: 2.0,
              child: const Icon(
                Icons.cached,
                color: Colors.white,
                size: 35,
              ),
            ),
          if (widget.video)
            RawMaterialButton(
              onPressed: _onToggleMuteVideo,
              elevation: 2.0,
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                _mutedVideo ? Icons.videocam_off : Icons.videocam,
                color: Colors.white,
                size: 35,
              ),
            ),
          RawMaterialButton(
            onPressed: _onToggleMuteAudio,
            elevation: 2.0,
            padding: const EdgeInsets.all(15.0),
            child: Icon(
              _mutedAudio ? Icons.mic_off : Icons.mic,
              color: Colors.white,
              size: 35,
            ),
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
