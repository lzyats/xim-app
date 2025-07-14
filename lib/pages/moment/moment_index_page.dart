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
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import 'dart:io';
//导入地图

// 导入 video_player 和 chewie
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class MomentIndexPage extends StatefulWidget {
  static const routeName = "/moment_index";

  const MomentIndexPage({super.key});
  @override
  State<MomentIndexPage> createState() => _MomentIndexPageState();
}

class _MomentIndexPageState extends State<MomentIndexPage> {
  final ScrollController _scrollController = ScrollController();
  late final MomentIndexController controller;
  TextEditingController _commentController = TextEditingController();
  MomentModel? _currentMoment;
  bool _isCommentInputVisible = false; // 新增标志位，用于控制输入框的显示和隐藏
  bool _isEmojiPickerVisible = false; // 新增标志位，用于控制表情符号选择器的显示和隐藏

  @override
  void initState() {
    super.initState();
    controller = Get.put(MomentIndexController());
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _commentController.dispose();
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
      body: Stack(
        children: [
          RefreshIndicator(
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
          if (_isCommentInputVisible)
            GestureDetector(
              onTap: () {
                setState(() {
                  _isCommentInputVisible = false;
                  _isEmojiPickerVisible = false;
                  _commentController.clear(); // 清空输入框内容
                });
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _commentController,
                              decoration: InputDecoration(
                                hintText: '请输入评论',
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                setState(() {
                                  // 监听输入框内容变化，更新按钮状态
                                });
                              },
                              onTap: () {
                                setState(() {
                                  _isEmojiPickerVisible = false;
                                });
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.insert_emoticon),
                            onPressed: () {
                              setState(() {
                                _isEmojiPickerVisible = !_isEmojiPickerVisible;
                              });
                            },
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(5), // 设置按钮圆角为 5
                              ),
                              disabledBackgroundColor: Colors.grey, // 不可用状态背景色
                              disabledForegroundColor:
                                  Colors.white.withOpacity(0.5), // 不可用状态文字颜色
                            ),
                            onPressed: _commentController.text.isEmpty
                                ? null
                                : () async {
                                    // 点击事件逻辑不变
                                    final commentContent =
                                        _commentController.text;
                                    //获取当前信息的momentId
                                    if (commentContent.isNotEmpty) {
                                      final success =
                                          await controller.addComment(
                                              _currentMoment?.momentId ?? 0,
                                              _currentMoment?.userId ?? 0,
                                              commentContent);
                                      if (success) {
                                        setState(() {
                                          _currentMoment?.comments ?? [];
                                          _currentMoment?.comments!.add(
                                            FriendCommentModel(
                                              fromUser:
                                                  controller.localUser.nickname,
                                              content: commentContent,
                                            ),
                                          );
                                          _commentController.clear();
                                          _isCommentInputVisible = false;
                                          _isEmojiPickerVisible = false;
                                        });
                                      }
                                    }
                                  },
                            child: Text('发送'),
                          ),
                        ],
                      ),
                    ),
                    if (_isEmojiPickerVisible)
                      SizedBox(
                        height: 250,
                        child: EmojiPicker(
                          onEmojiSelected: (Category? category, Emoji? emoji) {
                            if (emoji != null) {
                              _commentController.text =
                                  _commentController.text + emoji.emoji;
                              _commentController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset: _commentController.text.length),
                              );
                            }
                          },
                          onBackspacePressed: () {
                            if (_commentController.text.isNotEmpty) {
                              _commentController.text =
                                  _commentController.text.substring(
                                0,
                                _commentController.text.length - 1,
                              );
                              _commentController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset: _commentController.text.length),
                              );
                            }
                          },
                          config: Config(
                            height: 250,
                            swapCategoryAndBottomBar: false,
                            checkPlatformCompatibility: true,
                            emojiViewConfig: EmojiViewConfig(
                              columns: 7,
                              emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                              backgroundColor: const Color(0xFFF2F2F2),
                              verticalSpacing: 0,
                              horizontalSpacing: 0,
                              gridPadding: EdgeInsets.zero,
                              recentsLimit: 28,
                              replaceEmojiOnLimitExceed: false,
                              // 1. 添加 const 关键字修复 prefer_const_constructors 警告
                              noRecents: const Center(
                                child: Text(
                                  '暂无最近使用表情',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black26,
                                  ),
                                ),
                              ),
                              // 2. 添加 const 关键字
                              loadingIndicator: const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.grey),
                              ),
                              buttonMode: ButtonMode.MATERIAL,
                            ),
                            categoryViewConfig: CategoryViewConfig(
                              tabBarHeight: 48.0,
                              tabIndicatorAnimDuration:
                                  const Duration(milliseconds: 200),
                              initCategory: Category.RECENT,
                              recentTabBehavior: RecentTabBehavior.RECENT,
                              showBackspaceButton: false,
                              backgroundColor: const Color(0xFFF2F2F2),
                              indicatorColor: AppTheme.color,
                              iconColor: Colors.grey[600]!,
                              iconColorSelected: AppTheme.color,
                              backspaceColor: AppTheme.color,
                              dividerColor: Colors.grey.withOpacity(0.1),
                              categoryIcons: CategoryIcons(
                                recentIcon: Icons.access_time,
                                smileyIcon: Icons.tag_faces,
                                animalIcon: Icons.pets,
                                foodIcon: Icons.fastfood,
                                activityIcon: Icons.directions_run,
                                travelIcon: Icons.location_city,
                                objectIcon: Icons.lightbulb_outline,
                                symbolIcon: Icons.emoji_symbols,
                                flagIcon: Icons.flag,
                              ),
                              customCategoryView: null,
                            ),
                            // 3. 修复 SkinToneConfig：删除 enableSkinTones 参数，并添加 const 关键字
                            // 在 EmojiPicker 的 config 中修改 skinToneConfig
                            skinToneConfig: const SkinToneConfig(
                              enabled:
                                  true, // 对应新版参数，控制是否启用皮肤色调选择（替代原 enableSkinTones）
                              dialogBackgroundColor:
                                  Colors.white, // 新版参数名，替换原 dialogBgColor
                              indicatorColor: Colors.grey, // 保持不变，与新版参数名一致
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                      _renderComments(
                          moment.comments ?? [], moment.likes ?? []),
                  ],
                ),
              ),
            ],
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
  Widget _buildImageList(List<Media> picList) {
    if (picList.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = (constraints.maxWidth - 20) / 3;

        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: picList.map((media) {
            if (media == null) return const SizedBox.shrink();
            if (media.type == null) {
              print("警告：媒体资源 type 为 null，跳过处理");
              return const SizedBox.shrink();
            }

            if (media.type == 0) {
              // 图片逻辑（不变）
              return GestureDetector(
                onTap: () {
                  // 点击图片打开大图预览
                  _showImageViewer(picList, picList.indexOf(media));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl: media.url,
                    width: width,
                    height: width,
                    fit: BoxFit.cover,
                    // 图片加载中显示的占位符
                    placeholder: (context, url) => Container(
                      width: width,
                      height: width,
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 92, 104, 141),
                          ),
                        ),
                      ),
                    ),
                    // 图片加载失败显示的错误占位符
                    errorWidget: (context, url, error) => Container(
                      width: width,
                      height: width,
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              );
            } else if (media.type == 1) {
              // 视频逻辑（修改此处）
              return GestureDetector(
                onTap: () {
                  // 点击触发全屏播放
                  _playVideoFullscreen(media.url);
                },
                child: _buildVideoPlayerPlaceholder(
                  media.url, // 视频地址
                  media.thumbnail ?? '', // 封面图地址（核心修改）
                  width,
                  width,
                ),
              );
            }
            return const SizedBox.shrink();
          }).toList(),
        );
      },
    );
  }

  // 视频播放器占位符，可根据需求自定义样式
  // 视频播放器占位符（使用thumbnail作为封面）
  Widget _buildVideoPlayerPlaceholder(
      String videoUrl,
      String thumbnailUrl, // 新增封面图参数
      double width,
      double height) {
    return Container(
      width: width,
      height: height,
      // 使用CachedNetworkImage加载封面图
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 封面图
          CachedNetworkImage(
            imageUrl: thumbnailUrl,
            width: width,
            height: height,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[200],
              child: const Icon(Icons.video_library, color: Colors.grey),
            ),
          ),
          // 播放按钮覆盖层
          Icon(Icons.play_circle_outline, color: Colors.white, size: 50),
        ],
      ),
    );
  }

  // 全屏播放视频（实现点击退出）
  void _playVideoFullscreen(String videoUrl) {
    // 使用video_player和chewie实现全屏播放（需先添加依赖）
    // 1. 添加依赖到pubspec.yaml:
    // dependencies:
    //   video_player: ^2.8.1
    //   chewie: ^1.7.0

    // 2. 全屏播放实现
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true, // 全屏对话框模式（可滑动返回）
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              // 视频播放区域
              Center(
                child: _buildVideoPlayer(videoUrl),
              ),
              // 点击退出按钮（右上角）
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context), // 点击退出全屏
                ),
              ),
              // 点击空白区域也可退出
              GestureDetector(
                onTap: () => Navigator.pop(context),
                behavior: HitTestBehavior.translucent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 视频播放器核心组件（使用chewie包装video_player）
  Widget _buildVideoPlayer(String videoUrl) {
    final videoPlayerController = VideoPlayerController.network(videoUrl);
    final chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true, // 自动播放
      looping: false,
      allowFullScreen: false, // 此处已全屏，禁用内部全屏按钮
      allowMuting: true,
      aspectRatio: 16 / 9, // 自适应比例
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            '播放失败: $errorMessage',
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );

    // 页面销毁时释放资源
    // 使用 PopScope 替代 WillPopScope（Flutter 3.12+ 推荐）
    return PopScope(
      onPopInvoked: (didPop) {
        // 关键修复：移除 await，因为 dispose() 返回 void
        videoPlayerController.dispose();
        chewieController.dispose();
      },
      child: Chewie(controller: chewieController),
    );
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

    return Container(
      margin: const EdgeInsets.only(bottom: 15), // 新增下边距15
      child: Row(
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
                                  () => Navigator.pop(context), moment),
                              Container(
                                  width: 1,
                                  height: 30,
                                  color: Colors.grey.withOpacity(0.2)),
                              _buildMenuItem('评论', Icons.comment, () {
                                setState(() {
                                  _currentMoment = moment;
                                  _isCommentInputVisible = true;
                                });
                                Navigator.pop(context);
                              }, moment),
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
      ),
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
    // 使用 ?.then 进行空安全调用
    await Get.toNamed('/momnet_location', arguments: content)?.then((_) {
      _onRefresh();
    });
  }

  Widget _buildMenuItem(
      String text, IconData icon, VoidCallback onTap, MomentModel moment) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          if (text == '赞') {
            final controller = Get.find<MomentIndexController>();
            final success = await controller
                .likeMoment(moment.momentId ?? 0); // 假设 MomentModel 有一个 id 属性
            if (success) {
              setState(() {
                // 关键：确保 likes 不为 null（初始化空列表）
                moment.likes ?? [];
                // 检查当前用户是否已点赞
                final hasLiked =
                    moment.likes!.contains(controller.localUser.nickname);
                if (!hasLiked) {
                  moment.likes!.add(controller.localUser.nickname);
                  // 此时 likes 列表已非空，_renderLikes 会自动显示点赞区域
                }
              });
            }
          }
          onTap();
        },
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

  // 渲染点赞列表（新增方法）
  Widget _renderLikes(List<String> likes) {
    if (likes.isEmpty) {
      return const SizedBox.shrink(); // 点赞列表为空时不显示
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10), // 与评论区保持间距
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      color: const Color(0xFFF3F3F5).withOpacity(0.7), // 与评论区背景一致
      child: Row(
        children: [
          // 心形图标（点赞标志）
          const Icon(
            Icons.favorite,
            color: Colors.red,
            size: 16,
          ),
          const SizedBox(width: 8), // 图标与文字间距
          // 点赞用户列表（用逗号分隔）
          Expanded(
            child: Text(
              likes.join('、'), // 多个点赞用户用顿号分隔
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF636F80), // 与评论用户名颜色一致
              ),
              overflow: TextOverflow.ellipsis, // 超出时省略
            ),
          ),
        ],
      ),
    );
  }

  // 评论列表
  Widget _renderComments(
      List<FriendCommentModel> comments, List<String> likes) {
    // 新增：如果点赞和评论都为空，则不显示任何内容
    if (comments.isEmpty && likes.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        // 1. 先显示点赞列表（如果不为空）
        _renderLikes(likes),

        // 2. 再显示评论列表（如果不为空）
        if (comments.isNotEmpty)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: const Color(0xFFF3F3F5).withOpacity(0.7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: comments.map((comment) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text.rich(
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
                  ),
                );
              }).toList(),
            ),
          ),
      ],
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
