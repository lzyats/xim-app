import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

// 聊天=消息=文件
class ChatMessageFile extends StatelessWidget {
  final Map<String, dynamic> content;
  final String status;
  final double? width;
  const ChatMessageFile(
    this.content, {
    super.key,
    this.width,
    this.status = 'Y',
  });

  @override
  Widget build(BuildContext context) {
    // String mimeType = content['mimeType'];
    String title = content['title'] ?? '未知文件';
    return Container(
      padding: const EdgeInsets.all(10),
      height: 80,
      width: width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      _size(content['size']),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 123, 122, 122),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.insert_drive_file,
                size: 40,
              ),
            ],
          ),
          if ('R' == status)
            const Positioned(
              child: TDLoading(
                size: TDLoadingSize.large,
                icon: TDLoadingIcon.circle,
              ),
            ),
        ],
      ),
    );
  }

  _size(int size) {
    double result = size / 1.0;
    String unit = 'B';
    // GB
    if (size > 1073741824) {
      result = size / 1073741824;
      unit = 'GB';
    }
    // MB
    else if (size > 1048576) {
      result = size / 1048576;
      unit = 'MB';
    }
    // KB
    else if (size > 1024) {
      result = size / 1024;
      unit = 'KB';
    }
    return result.toStringAsFixed(1) + unit;
  }
}
