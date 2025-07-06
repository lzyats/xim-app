import 'dart:io';

import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/widgets/widget_action.dart';

class WidgetAmap extends StatefulWidget {
  final Function(Poi? pois, Uint8List? value) onTap;
  const WidgetAmap({super.key, required this.onTap});

  @override
  createState() => _DemoDituState();
}

class _DemoDituState extends State<WidgetAmap> {
  // 搜索框
  final TextEditingController _searchController = TextEditingController();
  // 控制器
  AmapController? _controller;
  late List<Poi> _poiList = [];
  List<MarkerOption>? _markers;

  @override
  void initState() {
    super.initState();
    // 初始化定位
    initdt();
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
  void dispose() {
    _searchController.dispose();
    AmapLocation.instance.dispose();
    _controller?.dispose();
    super.dispose();
  }

  // 搜索框
  _buildSearch() {
    return TextField(
      controller: _searchController,
      decoration: const InputDecoration(
        fillColor: Colors.white,
        hintText: '搜索地点',
      ),
      onChanged: (query) async {
        _poiList = [];
        _poiList = await AmapSearch.instance.searchKeyword(
          query,
        );
        setState(() {
          _onTapMove(latLng: _poiList.first.latLng);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('位置'),
          actions: [
            WidgetAction(
              onTap: () {
                _thumbnail();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Flexible(
              flex: 6,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  AmapView(
                    showZoomControl: false,
                    markers: _markers,
                    zoomLevel: 17,
                    onMapCreated: (controller) async {
                      _controller = controller;
                      await _controller?.showMyLocation(
                        MyLocationOption(
                          myLocationType: Platform.isAndroid
                              ? MyLocationType.Locate
                              : MyLocationType.Follow,
                        ),
                      );
                    },
                    onMapMoveEnd: _onMapMoveEnd,
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
            Container(
              padding: const EdgeInsets.all(6),
              color: const Color.fromARGB(255, 238, 235, 235),
              child: _buildSearch(),
            ),
            Flexible(
              flex: 5,
              child: Container(
                alignment: Alignment.center,
                child: ListView.builder(
                  itemCount: _poiList.length,
                  itemBuilder: (BuildContext itemContext, int i) {
                    Poi pois = _poiList[i];
                    return ListTile(
                      title: Text(pois.title ?? ""),
                      subtitle: Text(pois.address ?? ""),
                      trailing: pois.tel == '0'
                          ? Icon(
                              AppFonts.e60e,
                              color: AppTheme.color,
                            )
                          : null,
                      onTap: () {
                        _onTapMove(latLng: pois.latLng);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onMapMoveEnd(MapMove move) async {
    _searchController.text = "";
    _poiList = await AmapSearch.instance.searchAround(
      LatLng(
        move.coordinate!.latitude,
        move.coordinate!.longitude,
      ),
    );
    _poiList.first.tel = "0";
    MarkerOption markerOption = MarkerOption(
        coordinate: LatLng(
      move.coordinate!.latitude,
      move.coordinate!.longitude,
    ));
    _controller?.clear();
    _controller?.addMarker(markerOption);
    setState(() {});
  }

  // 地图初始化，移动定位地点
  _onTapMove({LatLng? latLng}) async {
    if (latLng == null) {
      await _controller?.showMyLocation(
        MyLocationOption(
          myLocationType: MyLocationType.Locate,
        ),
      );
    }
    LatLng coordinate = LatLng(latLng!.latitude, latLng.longitude);
    _controller?.setCameraPosition(
      coordinate: coordinate,
      zoom: 17,
    );
  }

  // 这个是截图的方法
  _thumbnail() async {
    Uint8List? uint8List = await _controller?.screenShot();
    widget.onTap(_poiList.first, uint8List);
  }
}
