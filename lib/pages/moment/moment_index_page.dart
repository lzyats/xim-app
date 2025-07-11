import 'package:alpaca/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/tools/tools_comment.dart';
import 'package:alpaca/pages/moment/moment_index_controller.dart';
import 'package:alpaca/pages/moment/momnet_add_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';

import 'package:alpaca/tools/tools_perms.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';

import 'dart:io';
//导入地图

class MomentIndexPage extends StatefulWidget {
  static const routeName = "/moment_index";

  const MomentIndexPage({super.key});
  @override
  State<MomentIndexPage> createState() => _MomentIndexPageState();
}

class _MomentIndexPageState extends State<MomentIndexPage> {
  final ScrollController _scrollController = ScrollController();
  late final MomentIndexController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(MomentIndexController());
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    Get.delete<MomentIndexController>();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      controller.onLoadMore();
    }
  }

  // 下拉刷新方法
  Future<void> _onRefresh() async {
    await controller.reloadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('朋友圈'),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: _openMomentAddPage,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.separated(
            controller: _scrollController,
            itemCount: controller.momentList.length +
                (controller.isLoadingMore.value ? 1 : 0),
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: Colors.grey.withOpacity(0.2),
            ),
            itemBuilder: (context, index) {
              if (index == controller.momentList.length &&
                  controller.isLoadingMore.value) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }

              final moment = controller.momentList[index];
              return _buildMomentItem(moment);
            },
          );
        }),
      ),
    );
  }

  // 正确的页面跳转方式
  void _openMomentAddPage() {
    // 方式1：直接创建页面实例（确保页面中已注册控制器）
    Get.to(() => const MomentAddPage())?.then((_) {
      _onRefresh();
    });
  }

  Widget _buildMomentItem(MomentModel moment) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatar(moment.portrait ?? ''),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: _buildMomentContent(moment),
                ),
                const SizedBox(height: 10),
                // 关键修改：传入媒体资源列表
                _buildImageList(moment.images ?? const []),
                _buildMomentFooter(moment),
                if (moment.comments != null)
                  _renderComments(moment.comments ?? []),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: CachedNetworkImage(
        imageUrl: url,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/image/error.png',
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildMomentContent(MomentModel moment) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            moment.nickname ?? '',
            style: const TextStyle(
              color: Color.fromARGB(255, 92, 104, 141),
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            moment.content ?? '',
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  // 关键修改：参数类型改为List<FriendMediaResourceModel>
  // 关键修改：参数类型改为List<FriendMediaResourceModel>
  Widget _buildImageList(List<Media> picList) {
    // 先检查列表是否为null
    if (picList.isEmpty) return const SizedBox.shrink();

    final List<Widget> mediaWidgets = [];

    if (picList.length == 2) {
      final rowWidgets = <Widget>[];
      for (int j = 0; j < 2; j++) {
        final media = picList[j];
        // 检查media对象是否为null
        if (media == null) {
          rowWidgets.add(const SizedBox.shrink());
          continue;
        }
        // 检查media的type属性是否为null
        if (media.type == null) {
          print("警告：媒体资源type为null，跳过处理");
          rowWidgets.add(const SizedBox.shrink());
          continue;
        }
        if (media.type == 0) {
          // 固定高度和宽度
          const double width = 150;
          const double height = 150;
          // 优化：根据媒体资源宽高计算适配比例
          BoxFit fit;
          if (media.width != null && media.height != null) {
            final ratio = media.width! / media.height!;
            fit = ratio > 1 ? BoxFit.cover : BoxFit.contain;
          } else {
            fit = BoxFit.cover;
          }
          rowWidgets.add(
            GestureDetector(
              onTap: () {
                _showImageViewer(picList, j);
              },
              child: CachedNetworkImage(
                imageUrl: media.url,
                width: width,
                height: height,
                fit: fit,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/image/error.png',
                  width: width,
                  height: height,
                  fit: fit,
                ),
              ),
            ),
          );
        } else if (media.type == 1) {
          const double width = 150;
          const double height = 150;
          rowWidgets.add(
            GestureDetector(
              onTap: () {
                _playVideo(media.url);
              },
              child: _buildVideoPlayerPlaceholder(media.url, width, height),
            ),
          );
        }
      }
      mediaWidgets.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: rowWidgets,
        ),
      );
    } else {
      for (int i = 0; i < picList.length; i += 3) {
        // 如果不是第一行，添加一个高度为10的SizedBox
        if (i != 0) {
          mediaWidgets.add(const SizedBox(height: 10));
        }
        final rowWidgets = <Widget>[];
        for (int j = 0; j < 3 && i + j < picList.length; j++) {
          final media = picList[i + j];
          // 检查media对象是否为null
          if (media == null) {
            rowWidgets.add(const SizedBox.shrink());
            continue;
          }
          // 检查media的type属性是否为null
          if (media.type == null) {
            print("警告：媒体资源type为null，跳过处理");
            rowWidgets.add(const SizedBox.shrink());
            continue;
          }
          if (media.type == 0) {
            // 固定高度和宽度
            const double width = 150;
            const double height = 150;
            // 优化：根据媒体资源宽高计算适配比例
            BoxFit fit;
            if (media.width != null && media.height != null) {
              final ratio = media.width! / media.height!;
              fit = ratio > 1 ? BoxFit.cover : BoxFit.contain;
            } else {
              fit = BoxFit.cover;
            }
            rowWidgets.add(
              GestureDetector(
                onTap: () {
                  _showImageViewer(picList, i + j);
                },
                child: CachedNetworkImage(
                  imageUrl: media.url,
                  width: width,
                  height: height,
                  fit: fit,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/image/error.png',
                    width: width,
                    height: height,
                    fit: fit,
                  ),
                ),
              ),
            );
          } else if (media.type == 1) {
            const double width = 150;
            const double height = 150;
            rowWidgets.add(
              GestureDetector(
                onTap: () {
                  _playVideo(media.url);
                },
                child: _buildVideoPlayerPlaceholder(media.url, width, height),
              ),
            );
          }
        }
        mediaWidgets.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: rowWidgets,
          ),
        );
      }
    }

    return Column(
      children: mediaWidgets,
    );
  }

// 视频播放器占位符，可根据需求自定义样式
  Widget _buildVideoPlayerPlaceholder(
      String videoUrl, double width, double height) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey,
      child: Center(
        child: Icon(Icons.play_circle_outline, color: Colors.white, size: 50),
      ),
    );
  }

  // 播放视频的方法，这里只是简单示例，需要根据实际情况实现
  void _playVideo(String videoUrl) {
    // 这里可以使用 video_player 等库来实现视频播放
    print('Playing video: $videoUrl');
  }

  // 图片浏览及缩放（优化：支持媒体资源元数据）
  void _showImageViewer(List<Media> picList, int initialIndex) {
    final RxInt currentIndex = initialIndex.obs;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: SafeArea(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Scaffold(
                backgroundColor: Colors.black,
                body: Stack(
                  children: [
                    // 每次打开时创建新的 PhotoViewContainer 实例
                    PhotoViewContainer(
                      picList: picList,
                      initialIndex: initialIndex,
                      currentIndex: currentIndex,
                    ),
                    // 关闭按钮（提升层级至顶部）
                    Positioned(
                      top: 16,
                      right: 16,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    // 底部指示器（提升层级至顶部）
                    Positioned(
                      bottom: 24,
                      left: 0,
                      right: 0,
                      child: Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: picList.asMap().entries.map((entry) {
                            int index = entry.key;
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentIndex.value == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMomentFooter(MomentModel moment) {
    String? locationText;
    double? longitude;
    double? latitude;

    if (moment.location != null) {
      final parts = moment.location!.split('|');
      if (parts.length >= 1) {
        locationText = parts[0];
        if (parts.length >= 3) {
          try {
            longitude = double.parse(parts[1]);
            latitude = double.parse(parts[2]);
          } catch (e) {
            print('经纬度解析失败: $e');
          }
        }

        if (locationText.length > 30) {
          locationText = '${locationText.substring(0, 28)}..';
        }
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              moment.createTime ?? '',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        if (locationText != null)
          GestureDetector(
            onTap: () {
              _openGaodeMap(longitude, latitude, locationText ?? '');
            },
            child: Text(
              locationText,
              style: const TextStyle(
                color: Color.fromARGB(255, 92, 104, 141),
                fontSize: 12,
              ),
            ),
          ),
        GestureDetector(
          onTapDown: (TapDownDetails details) async {
            // 获取点击位置的坐标（屏幕坐标系）
            final RenderBox overlay =
                Overlay.of(context)!.context.findRenderObject() as RenderBox;
            final tapPosition = overlay.globalToLocal(details.globalPosition);

            // 显示包含坐标信息的弹窗
            final result = await showMenu(
              context: context,
              position: _calculateMenuPosition(context, tapPosition),
              items: [
                PopupMenuItem(
                  padding: EdgeInsets.zero,
                  child: Container(
                    width: 240,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildMenuItem('赞', Icons.thumb_up,
                                () => Navigator.pop(context)),
                            Container(
                                width: 1,
                                height: 30,
                                color: Colors.grey.withOpacity(0.2)),
                            _buildMenuItem('评论', Icons.comment,
                                () => Navigator.pop(context)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              color: Colors.grey[800], // 设置菜单背景颜色为灰黑色
            );
          },
          child: const Icon(Icons.more_horiz),
        ),
      ],
    );
  }

// 打开地图显示位置
  void _openGaodeMap(
      double? longitude, double? latitude, String locationName) async {
    if (longitude == null || latitude == null) {
      Get.snackbar(
        '位置导航',
        '未获取到有效经纬度$longitude，无法打开地图',
        duration: const Duration(seconds: 2),
      );
      return;
    }
    //修改后的打开地图
    // 权限
    bool result = await ToolsPerms.location();
    if (!result) {
      return;
    }
    //拼接content信息
    Map<String, dynamic> content = {
      'title': locationName,
      'address': locationName,
      'longitude': longitude,
      'latitude': latitude
    };
    //Map<String, dynamic> reply = jsonDecode(content['content']);

    // 使用 ?.then 进行空安全调用
    await Get.toNamed('/momnet_location', arguments: content)?.then((_) {
      _onRefresh();
    });
    /* final url =
        'amapuri://route/plan/?dlat=$latitude&dlon=$longitude&dname=$locationName&dev=0&t=0';

    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)
        .catchError((e) {
      Get.snackbar(
        '位置导航',
        '无法打开高德地图，请检查是否已安装',
        duration: const Duration(seconds: 2),
      );
      print('地图跳转失败: $e');
    }); */
  }

  Widget _buildMenuItem(String text, IconData icon, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white), // 修改图标颜色为白色
              const SizedBox(width: 8),
              Text(text, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderComments(List<FriendCommentModel> comments) {
    return Container(
      margin: const EdgeInsets.only(top: 2, bottom: 20),
      padding: const EdgeInsets.all(10),
      color: const Color(0xFFF3F3F5).withOpacity(0.7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: comments.map((comment) {
          return Text.rich(
            TextSpan(
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF333333),
              ),
              children: [
                TextSpan(
                  text: comment.fromUser,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF636F80),
                  ),
                ),
                TextSpan(text: '：${comment.content}'),
              ]..insertAll(
                  1,
                  comment.source ?? true
                      ? [const TextSpan()]
                      : [
                          const TextSpan(text: ' 回复 '),
                          TextSpan(
                            text: comment.toUser,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF636F80),
                            ),
                          ),
                        ],
                ),
            ),
          );
        }).toList(),
      ),
    );
  }

  RelativeRect _calculateMenuPosition(
      BuildContext context, Offset tapPosition) {
    final screenSize = MediaQuery.of(context).size;
    const double menuWidth = 240; // 调整宽度以容纳坐标文本
    const double maxMenuHeight = 120; // 调整高度

    // 计算菜单位置（仍居中显示，但可根据点击位置微调）
    double menuLeft =
        (screenSize.width - menuWidth) / 2 + menuWidth / 4.2; // 右移整个宽度的五分之一
    double menuTop = tapPosition.dy + 20 - maxMenuHeight / 2.2; // 上移整个高度的二分之一

    // 确保菜单不超出屏幕边界
    if (menuTop < 0) menuTop = 0;
    if (menuTop + maxMenuHeight > screenSize.height) {
      menuTop = screenSize.height - maxMenuHeight;
    }
    if (menuLeft < 0) menuLeft = 0;
    if (menuLeft + menuWidth > screenSize.width) {
      menuLeft = screenSize.width - menuWidth;
    }

    return RelativeRect.fromLTRB(
      menuLeft,
      menuTop,
      menuLeft + menuWidth,
      menuTop + maxMenuHeight,
    );
  }
}

class PhotoViewContainer extends StatelessWidget {
  final List<Media> picList;
  final int initialIndex;
  final RxInt currentIndex;

  const PhotoViewContainer({
    Key? key,
    required this.picList,
    required this.initialIndex,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Swiper(
        itemCount: picList.length,
        index: initialIndex,
        onIndexChanged: (index) {
          currentIndex.value = index;
        },
        itemBuilder: (context, index) {
          final media = picList[index];
          return PhotoView(
            imageProvider: CachedNetworkImageProvider(media.url),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
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
  bool _isAmapLocationInitialized = false; // 添加标志位
  bool _isReceiverRegistered = false; // 新增标志位

  @override
  void initState() {
    super.initState();
    initdt();
  }

  @override
  void dispose() {
    super.dispose();
    if (_isAmapLocationInitialized) {
      // 检查是否已经初始化
      try {
        if (_isReceiverRegistered) {
          // 检查接收器是否已注册
          AmapLocation.instance.dispose();
        }
      } catch (e) {
        print('Error disposing AmapLocation: $e');
      }
    }
    _controller.dispose();
  }

  initdt() async {
    await AmapLocation.instance.updatePrivacyShow(true);
    await AmapLocation.instance.updatePrivacyAgree(true);
    if (Platform.isIOS) {
      await AmapLocation.instance.init(iosKey: AppConfig.amapIos);
      await AmapCore.init(AppConfig.amapIos);
    }
    _isAmapLocationInitialized = true; // 初始化完成后设置标志位
    _isReceiverRegistered = true; // 设置接收器已注册标志位
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
