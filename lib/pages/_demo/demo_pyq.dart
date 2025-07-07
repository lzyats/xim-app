import 'package:flutter/material.dart';
import 'package:alpaca/config/app_resource.dart';
import 'package:alpaca/widgets/widget_common.dart';

class DemoPyq extends StatelessWidget {
  static const routeName = "/demo_pyq";

  const DemoPyq({super.key});

  static List<FriendCircleViewModel> friendCircleDatas = [
    FriendCircleViewModel(
      userName: '小石头1',
      userImgUrl: AppImage.bank,
      saying: '听说Flutter很🔥，我也来凑热闹，github上建了一个仓库，欢迎来撩~✌✌✌',
      pic: AppImage.bank,
      createTime: '2小时前',
      comments: [
        const Comment(
            source: true, fromUser: '若海', toUser: '小石头', content: '性能如何？'),
        const Comment(
            source: false,
            fromUser: '小石头',
            toUser: '若海',
            content: '性能不错，但是开发体验感觉差一点。。。'),
        const Comment(
            source: false,
            fromUser: '若海',
            toUser: '小石头',
            content: '周末我也试试，嘻嘻~'),
        const Comment(
            source: true, fromUser: '大佬', toUser: '小石头', content: '卧槽，求求你别学了'),
        const Comment(
            source: true,
            fromUser: '产品',
            toUser: '小石头',
            content: '工作量不饱和啊你这是！'),
        const Comment(
            source: false,
            fromUser: '小石头',
            toUser: '大佬',
            content: '卧槽，大佬别闹，学不动了。。。'),
        const Comment(
            source: false,
            fromUser: '小石头',
            toUser: '产品',
            content: '不不不，你的需求都已经完成了~！'),
      ],
    ),
    FriendCircleViewModel(
      userName: '小石头2',
      userImgUrl: AppImage.bank,
      saying: '听说Flutter很🔥，我也来凑热闹，github上建了一个仓库，欢迎来撩~✌✌✌',
      pic: AppImage.bank,
      createTime: '2小时前',
      comments: [
        const Comment(
            source: true, fromUser: '若海', toUser: '小石头', content: '性能如何？'),
        const Comment(
            source: false,
            fromUser: '小石头',
            toUser: '若海',
            content: '性能不错，但是开发体验感觉差一点。。。'),
        const Comment(
            source: false,
            fromUser: '若海',
            toUser: '小石头',
            content: '周末我也试试，嘻嘻~'),
        const Comment(
            source: true, fromUser: '大佬', toUser: '小石头', content: '卧槽，求求你别学了'),
        const Comment(
            source: true,
            fromUser: '产品',
            toUser: '小石头',
            content: '工作量不饱和啊你这是！'),
        const Comment(
            source: false,
            fromUser: '小石头',
            toUser: '大佬',
            content: '卧槽，大佬别闹，学不动了。。。'),
        const Comment(
            source: false,
            fromUser: '小石头',
            toUser: '产品',
            content: '不不不，你的需求都已经完成了~！'),
      ],
    ),
    FriendCircleViewModel(
        userName: '小石头3',
        userImgUrl: AppImage.bank,
        saying: '听说Flutter很🔥，我也来凑热闹，github上建了一个仓库，欢迎来撩~✌✌✌',
        pic: AppImage.bank,
        createTime: '2小时前',
        comments: [
          const Comment(
              source: true, fromUser: '若海', toUser: '小石头', content: '性能如何？'),
          const Comment(
              source: false,
              fromUser: '小石头',
              toUser: '若海',
              content: '性能不错，但是开发体验感觉差一点。。。'),
          const Comment(
              source: false,
              fromUser: '若海',
              toUser: '小石头',
              content: '周末我也试试，嘻嘻~'),
          const Comment(
              source: true,
              fromUser: '大佬',
              toUser: '小石头',
              content: '卧槽，求求你别学了'),
          const Comment(
              source: true,
              fromUser: '产品',
              toUser: '小石头',
              content: '工作量不饱和啊你这是！'),
          const Comment(
              source: false,
              fromUser: '小石头',
              toUser: '大佬',
              content: '卧槽，大佬别闹，学不动了。。。'),
          const Comment(
              source: false,
              fromUser: '小石头',
              toUser: '产品',
              content: '不不不，你的需求都已经完成了~！'),
        ]),
  ];

  Widget renderComments(FriendCircleViewModel friendCircleData) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      color: const Color(0xFFF3F3F5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: friendCircleData.comments.map((comment) {
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
                  comment.source
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('朋友圈展示'),
      ),
      body: ListView.separated(
        itemCount: friendCircleDatas.length,
        separatorBuilder: (BuildContext context, int index) {
          // 构建分割线
          return WidgetCommon.divider();
        },
        itemBuilder: (context, index) {
          return _test(friendCircleDatas[index]);
        },
      ),
    );
  }

  Container _test(FriendCircleViewModel friendCircleData) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: GestureDetector(
                onTap: () {
                  //预留跳转个人详情界面
                },
                child: Image.asset(
                  friendCircleData.userImgUrl,
                  width: 50,
                  height: 50,
                ),
              )),
          const Padding(padding: EdgeInsets.only(left: 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  friendCircleData.userName,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF636F80),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 6)),
                Text(
                  friendCircleData.saying,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.2,
                    color: Color(0xFF333333),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(
                    friendCircleData.pic,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      friendCircleData.createTime,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF999999),
                      ),
                    ),
                    const Icon(
                      Icons.comment,
                      size: 16,
                      color: Color(0xFF999999),
                    ),
                  ],
                ),
                renderComments(friendCircleData),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FriendCircleViewModel {
  /// 用户名
  final String userName;

  /// 用户头像地址
  final String userImgUrl;

  /// 说说
  final String saying;

  /// 图片
  final String pic;

  ///发布时间
  final String createTime;

  /// 评论内容
  final List<Comment> comments;

  const FriendCircleViewModel({
    required this.userName,
    required this.userImgUrl,
    required this.saying,
    required this.pic,
    required this.createTime,
    required this.comments,
  });
}

class Comment {
  /// 是否发起人
  final bool source;

  /// 评论者
  final String fromUser;

  /// 被评论者
  final String toUser;

  // 评论内容
  final String content;

  const Comment({
    required this.source,
    required this.fromUser,
    required this.toUser,
    required this.content,
  });
}
