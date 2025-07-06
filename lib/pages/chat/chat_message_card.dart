import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/friend/friend_details_page.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/widgets/widget_card.dart';

// 聊天=消息=名片
class ChatMessageCard extends StatelessWidget {
  final Map<String, dynamic> content;
  const ChatMessageCard(
    this.content, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String userId = content['userId'];
    String nickname = content['nickname'];
    String portrait = content['portrait'];
    String userNo = content['userNo'];
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          FriendDetailsPage.routeName,
          arguments: {
            "userId": userId,
            "source": FriendSource.card,
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 120,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 3,
              child: WidgetCard(
                nickname: nickname,
                portrait: portrait,
                userNo: userNo,
              ),
            ),
            const Flexible(
              child: Text(
                '[推荐名片]',
                style: TextStyle(
                  color: Color.fromARGB(255, 123, 122, 122),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
