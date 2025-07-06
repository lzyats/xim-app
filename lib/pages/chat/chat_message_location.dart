import 'dart:io';

import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/tools/tools_perms.dart';

import 'package:get/route_manager.dart';
import 'package:alpaca/widgets/widget_image.dart';

// 聊天=消息=地理位置
class ChatMessageLocation extends StatelessWidget {
  final Map<String, dynamic> content;
  final double? width;
  const ChatMessageLocation(
    this.content, {
    super.key,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    String title = content['title'];
    String address = content['address'];
    String thumbnail = content['thumbnail'];
    return GestureDetector(
      onTap: () async {
        // 权限
        bool result = await ToolsPerms.location();
        if (!result) {
          return;
        }
        Get.to(const ChatMessageLocationItem(), arguments: content);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          height: 150,
          width: width,
          padding: const EdgeInsets.all(2),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: WidgetImage(
                  thumbnail,
                  ImageType.network,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  address,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 123, 122, 122),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatMessageLocationItem extends StatefulWidget {
  const ChatMessageLocationItem({super.key});

  @override
  createState() => _ChatMessageLocationItemState();
}

class _ChatMessageLocationItemState extends State<ChatMessageLocationItem> {
  // 控制器
  late AmapController _controller;
  List<MarkerOption>? _markers;

  Map<String, dynamic> content = Get.arguments;

  @override
  void initState() {
    super.initState();
    initdt();
  }

  @override
  void dispose() {
    super.dispose();
    AmapLocation.instance.dispose();
    _controller.dispose();
  }

  initdt() async {
    await AmapLocation.instance.updatePrivacyShow(true);
    await AmapLocation.instance.updatePrivacyAgree(true);
    if (Platform.isIOS) {
      await AmapLocation.instance.init(iosKey: AppConfig.amapIos);
      await AmapCore.init(AppConfig.amapIos);
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = content['title'];
    String address = content['address'];
    double latitude = double.parse(content['latitude'].toString());
    double longitude = double.parse(content['longitude'].toString());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('位置'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                AmapView(
                  showZoomControl: false,
                  markers: _markers,
                  zoomLevel: 17,
                  onMapCreated: (controller) async {
                    _controller = controller;
                    _onMapMoveEnd(LatLng(latitude, longitude));
                  },
                ),
                Positioned(
                  child: FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    foregroundColor: AppTheme.color,
                    mini: true,
                    onPressed: () {
                      _onTapMove();
                    },
                    child: const Icon(Icons.gps_fixed),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: ListTile(
                    title: Text(title),
                    subtitle: Text(address),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //移动搜索周边，并在地图中心打点
  _onMapMoveEnd(LatLng move) {
    _controller.setCameraPosition(
      coordinate: move,
      zoom: 17,
    );
    MarkerOption markerOption = MarkerOption(coordinate: move);
    _controller.clear();
    _controller.addMarker(markerOption);
    setState(() {});
  }

  // 地图初始化，移动定位地点
  _onTapMove({LatLng? latLng}) async {
    if (latLng == null) {
      await _controller.showMyLocation(
        MyLocationOption(
          myLocationType: MyLocationType.Locate,
        ),
      );
    }
  }
}
