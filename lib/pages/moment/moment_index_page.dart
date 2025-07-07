import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/tools/tools_comment.dart';
import 'package:alpaca/pages/moment/moment_index_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('朋友圈')),
      body: Obx(() {
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
    );
  }

  Widget _buildMomentItem(MomentModel moment) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatar(moment.portrait),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMomentContent(moment),
                const SizedBox(height: 10),
                _buildImageList(moment.images),
                _buildMomentFooter(moment),
                if (moment.comments.isNotEmpty)
                  _renderComments(moment.comments),
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
      child: _buildImageWithStatusCodeCheck(
        url: url,
        width: 40,
        height: 40,
      ),
    );
  }

  Widget _buildMomentContent(MomentModel moment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          moment.nickname,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          moment.content,
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildImageList(List<String> picList) {
    if (picList.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: picList.map((picUrl) {
        return _buildImageWithStatusCodeCheck(
          url: picUrl,
          width: 100,
          height: 100,
        );
      }).toList(),
    );
  }

  Widget _buildMomentFooter(MomentModel moment) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          moment.createTime,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () async {
            final RenderBox button = context.findRenderObject() as RenderBox;
            final Offset buttonPosition = button.localToGlobal(Offset.zero);

            final RenderBox listItemBox =
                context.findRenderObject() as RenderBox;
            final Offset listItemPosition =
                listItemBox.localToGlobal(Offset.zero);
            final Size listItemSize = listItemBox.size;

            // 修改这里，将高度压缩三分之一
            final double maxMenuHeight = (listItemSize.height -
                    (buttonPosition.dy - listItemPosition.dy)) *
                (2 / 3);

            final result = await showMenu(
              context: context,
              position: RelativeRect.fromLTRB(
                buttonPosition.dx - 180,
                buttonPosition.dy,
                buttonPosition.dx - 20,
                buttonPosition.dy + maxMenuHeight,
              ),
              items: [
                PopupMenuItem(
                  padding: EdgeInsets.zero,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMenuItem('赞', Icons.thumb_up, () {
                        Navigator.pop(context);
                      }),
                      Container(
                        width: 1,
                        height: 30,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      _buildMenuItem('评论', Icons.comment, () {
                        Navigator.pop(context);
                      }),
                    ],
                  ),
                ),
              ],
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            );
          },
        ),
      ],
    );
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
              Icon(icon),
              const SizedBox(width: 8),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageWithStatusCodeCheck({
    required String url,
    required double width,
    required double height,
  }) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Image.asset(
        'assets/image/error.png',
        width: width,
        height: height,
        fit: BoxFit.cover,
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
              style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
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
                  //comment.source
                  //     ? []
                  [
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
}
