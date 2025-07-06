import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 聊天=底部=表情
class ChatBottomEmoji extends StatelessWidget {
  final TextEditingController textController;
  const ChatBottomEmoji(this.textController, {super.key});

  @override
  Widget build(BuildContext context) {
    // Issue: https://github.com/flutter/flutter/issues/28894
    return EmojiPicker(
      textEditingController: textController,
      onBackspacePressed: () {},
      config: Config(
        // 表情集合（可定制）
        // emojiSet: _defaultEmojiSet(),
        // 显示区域
        emojiViewConfig: EmojiViewConfig(
          emojiSizeMax: 28,
          noRecents: WidgetCommon.none(),
        ),
        // 分类区域
        categoryViewConfig: const CategoryViewConfig(
          // 删除按钮
          showBackspaceButton: true,
          // 定义类型图标
          // categoryIcons: CategoryIcons(),
          // 默认分类
          // initCategory: Category.SMILEYS,
          // 不显示/最近标签/最常用
          recentTabBehavior: RecentTabBehavior.NONE,
        ),
        // 底部区域
        bottomActionBarConfig: const BottomActionBarConfig(
          // 底部开关
          enabled: false,
        ),
      ),
    );
  }

  _defaultEmojiSet() {
    return [
      const CategoryEmoji(
        Category.RECENT,
        [
          Emoji('😀', 'Grinning Face'),
          Emoji('😀', 'Grinning Face'),
          Emoji('😀', 'Grinning Face'),
          Emoji('😀', 'Grinning Face'),
          Emoji('😀', 'Grinning Face'),
          Emoji('😀', 'Grinning Face'),
          Emoji('😀', 'Grinning Face'),
        ],
      ),
    ];
  }
}
