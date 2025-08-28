import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/tools/tools_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/tools/tools_comment.dart';
import 'package:alpaca/pages/moment/moment_index_controller.dart';
import 'package:alpaca/pages/moment/momnet_add_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:alpaca/widgets/widget_moment.dart';

import 'dart:io';
//导入地图

import 'package:timeago/timeago.dart' as timeago;

import 'package:alpaca/pages/moment/moment_info_page.dart';

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
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _commentController.dispose();
    Get.delete<MomentIndexController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFC6DBF7), Color(0xFFE6EFFA)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0], // 颜色分布点
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              '朋友圈',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: _openMomentAddPage,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: controller.onRefresh1,
            child: Obx(() {
              // 核心修改：无论数据是否为空，都使用ListView确保可下拉
              return ListView.separated(
                controller: _scrollController,
                // 数据为空时，设置itemCount为1（显示空状态）；否则为实际数据量+加载更多项
                itemCount: controller.momentList.isEmpty
                    ? 1
                    : controller.momentList.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: Colors.grey.withOpacity(0.2),
                ),
                itemBuilder: (context, index) {
                  if (controller.momentList.isEmpty) {
                    return _buildEmptyState();
                  }
                  // 如果是最后一项且有更多数据，显示加载中
                  if (index == controller.momentList.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  // 正常数据项
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

  // 正确的页面跳转方式（修改后）
  void _openMomentAddPage() {
    // 方式1：直接创建页面实例，监听返回结果
    Get.to(() => const MomentAddPage())?.then((result) {
      // 若返回结果为true（表示提交成功），则刷新当前页面
      if (result == true) {}
    });
  }

  // 新增：空状态显示组件
  Widget _buildEmptyState() {
    return Container(
      // 高度占满屏幕，确保可下拉
      height: MediaQuery.of(context).size.height -
          kToolbarHeight -
          MediaQuery.of(context).padding.top,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 空状态图标
          Icon(
            Icons.photo_library_outlined,
            size: 60,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 20),
          // 空状态文本
          Text(
            '暂无朋友圈内容',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          // 提示文本
          Text(
            '下拉可以刷新内容',
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  //朋友圈列表项
  Widget _buildMomentItem(MomentModel moment) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(moment.portrait ?? '', moment),
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

  //朋友圈头像
  Widget _buildAvatar(String url, MomentModel moment) {
    return InkWell(
      // 使用InkWell替代GestureDetector
      onTap: () {
        /* 原有跳转逻辑 */
        // 验证userId是否存在
        if (moment.userId == null || moment.userId == 0) {
          // 这里将isEmpty改为判断是否为0
          Get.snackbar('错误', '用户ID不存在，无法查看详情');
          return;
        }
        // 核心修改：使用Get.to(Widget实例)方式跳转，与MomentAddPage保持一致
        Get.to(
          () => MomentInfoPage(
              userId: moment.userId!.toString(), // 直接传递userId参数（非命名路由参数）
              nickname: moment.nickname!.toString()),
        )?.then((_) {
          // 返回到当前页面时刷新数据（与MomentAddPage的回调逻辑一致）
          //_onRefresh();
        });
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
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
          )),
    );
  }

  // 朋友圈信息正文（修改：添加昵称点击事件）
  Widget _buildMomentContent(MomentModel moment) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 点击用户昵称打开MomentInfoPage
          GestureDetector(
            onTap: () {
              // 验证userId是否存在
              if (moment.userId == null || moment.userId == 0) {
                // 这里将isEmpty改为判断是否为0
                Get.snackbar('错误', '用户ID不存在，无法查看详情');
                return;
              }
              // 核心修改：使用Get.to(Widget实例)方式跳转，与MomentAddPage保持一致
              Get.to(
                () => MomentInfoPage(
                    userId: moment.userId!.toString(), // 直接传递userId参数（非命名路由参数）
                    nickname: moment.nickname!.toString()),
              )?.then((_) {
                // 返回到当前页面时刷新数据（与MomentAddPage的回调逻辑一致）
                //_onRefresh();
              });
            },
            child: Text(
              moment.nickname ?? '',
              style: const TextStyle(
                color: Color.fromARGB(255, 92, 104, 141),
                fontSize: 16,
              ),
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

  // 抽取占位符和错误widget为单独方法（复用）
  Widget _buildPlaceholder(double size) {
    return Container(
      width: size,
      height: size,
      color: Colors.grey[200],
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor:
              AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 92, 104, 141)),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(double size) {
    return Container(
      width: size,
      height: size,
      color: Colors.grey[200],
      child: const Icon(
        Icons.image_not_supported,
        color: Colors.grey,
        size: 30,
      ),
    );
  }

  // 关键修改：参数类型改为List<FriendMediaResourceModel>
  Widget _buildImageList(List<Media> picList) {
    if (picList.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        // 单张媒体处理（区分图片/视频，并添加交互逻辑）
        if (picList.length == 1) {
          final Media media = picList.first;
          if (media == null || media.type == null) {
            return const SizedBox.shrink();
          }

          // 单张视频处理（添加播放交互）
          if (media.type == 1) {
            return GestureDetector(
              // 新增：视频点击播放
              onTap: () => WidgetMoment.playVideoFullscreen(context, media),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                constraints: const BoxConstraints(
                  maxWidth: 300,
                ),
                child: _buildVideoPlayerPlaceholder(
                  media.url,
                  media.thumbnail ?? '',
                  constraints.maxWidth / 2,
                  200, // 当宽高无效时，使用默认高度200
                ),
              ),
            );
          }

          // 单张图片处理（添加预览交互）
          return GestureDetector(
            // 新增：图片点击预览
            onTap: () =>
                WidgetMoment.showImageViewer(context, picList, 0), // 索引固定为0（单张）
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              constraints: const BoxConstraints(maxHeight: 300),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  // 缩略图判断逻辑（包含http则使用缩略图）
                  imageUrl: media.thumbnail?.contains('http') == true
                      ? media.thumbnail!
                      : media.url,
                  width: constraints.maxWidth / 2,
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                      _buildPlaceholder(constraints.maxWidth / 2),
                  errorWidget: (context, url, error) =>
                      _buildErrorWidget(constraints.maxWidth / 2),
                ),
              ),
            ),
          );
        }

        // 多张媒体处理（3列网格，保持原有交互）
        final double width = (constraints.maxWidth - 20) / 3;
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: picList.asMap().entries.map((entry) {
            final int index = entry.key;
            final Media media = entry.value;

            if (media == null) return const SizedBox.shrink();
            if (media.type == null) {
              debugPrint("警告：媒体资源 type 为 null，跳过处理");
              return const SizedBox.shrink();
            }

            // 图片处理（点击预览）
            if (media.type == 0) {
              return GestureDetector(
                onTap: () =>
                    WidgetMoment.showImageViewer(context, picList, index),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl: media.thumbnail?.contains('http') == true
                        ? media.thumbnail!
                        : media.url,
                    width: width,
                    height: width,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => _buildPlaceholder(width),
                    errorWidget: (context, url, error) =>
                        _buildErrorWidget(width),
                  ),
                ),
              );
            }
            // 视频处理（点击播放）
            else if (media.type == 1) {
              return GestureDetector(
                onTap: () => WidgetMoment.playVideoFullscreen(context, media),
                child: _buildVideoPlayerPlaceholder(
                  media.url,
                  media.thumbnail ?? '',
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

  // 修改 _buildMomentFooter 方法，添加删除图标
  Widget _buildMomentFooter(MomentModel moment) {
    timeago.setLocaleMessages('en', ToolsFormat());
    // 获取当前登录用户ID（假设从控制器中获取）
    final currentUserId = controller.userId; // 需确保控制器中有此属性
    bool hasdel = false;
    int strlen = 20;
    if (moment.userId != null &&
        currentUserId != null &&
        moment.userId.toString() == currentUserId) hasdel = true;
    if (hasdel) strlen = 18;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 时间和删除图标
          Row(
            children: [
              Text(
                moment.createTime != null
                    ? timeago.format(moment.createTime!)
                    : '',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              // 只有当前用户发布的朋友圈才显示删除图标
              if (hasdel)
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.black, size: 15),
                  onPressed: () => _showDeleteConfirmation(moment),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
            ],
          ),
          WidgetMoment.buildLocationWidget(moment.location, strlen: strlen),
          // 更多操作按钮（保持不变）
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

// 添加删除确认对话框方法
  Future<void> _showDeleteConfirmation(MomentModel moment) async {
    final result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              // 设置圆角（默认值较大，这里改为8）
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // 减小圆角半径
              ),
              // 设置标题居中
              title: const Center(
                child: Text('确认删除'),
              ),
              content: const Text('确定要删除这条朋友圈吗？此操作不可撤销。'),
              // 调整actions布局使按钮居中
              actions: [
                // 使用Row包裹按钮，并设置主轴对齐方式为居中
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('取消'),
                    ),
                    const SizedBox(width: 20), // 增加按钮间距
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child:
                          const Text('删除', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ],
            ));

    // 如果用户确认删除，调用控制器的删除方法
    if (result == true) {
      final success = await controller.deleteMoment(
          moment.momentId ?? 0, moment.msgId ?? 0);
      if (success) {
        Get.snackbar('成功', '朋友圈已删除');
      } else {
        Get.snackbar('失败', '删除失败，请稍后重试');
      }
    }
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
            /* if (success) {
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
            } */
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
    if (likes == null || likes.isEmpty) {
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
                          comment.source ?? false
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
