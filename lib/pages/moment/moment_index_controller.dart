// lib/pages/moment/moment_index_controller.dart
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/tools/tools_comment.dart';
import 'package:get/get.dart';
//添加通用网络请求
import 'package:alpaca/request/request_moment.dart';

class MomentIndexController extends BaseController {
  // 朋友圈列表
  //List<Moment> momentList = [];
  final RxList<MomentModel> momentList = RxList<MomentModel>([]);

  // 数据加载状态
  final Rx<bool> isLoading = Rx<bool>(false);

  // 下滑加载状态
  final Rx<bool> isLoadingMore = Rx<bool>(false);

  // 当前页码
  int currentPage = 1;

  // 每页数量
  int pageSize = 10;

  // 刷新
  Future<void> _onRefresh() async {
    currentPage = 1;
    isLoading.value = true;
    update();

    try {
      momentList.value = await getMoments(currentPage, pageSize);
    } catch (e) {
      print('Error loading moments: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  // 下滑加载更多（确保此方法存在）
  Future<void> onLoadMore() async {
    if (isLoadingMore.value) return;
    isLoadingMore.value = true;
    update();

    try {
      currentPage++;
      List<MomentModel> newMoments = await getMoments(currentPage, pageSize);
      if (newMoments.isNotEmpty) {
        momentList.addAll(newMoments);
      }
    } catch (e) {
      print('Error loading more moments: $e');
      currentPage--;
    } finally {
      isLoadingMore.value = false;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    update();

    _onRefresh();
    print(momentList.isEmpty);

    Future.delayed(Duration.zero, () {
      isLoading.value = false;
      update();
    });
  }
}

// 模拟API请求（确保参数正确）
Future<List<MomentModel>> getMoments(int page, int pageSize) async {
  await Future.delayed(Duration(seconds: 1));

  if (page == 1) {
    return [
      MomentModel(
        momentId: 10002,
        userId: 1939140554751221762,
        nickname: '小王',
        portrait:
            'https://img0.baidu.com/it/u=1234567890,0987654321&fm=26&fmt=auto&app=138&f=JPEG?w=500&h=375',
        content: '今天去爬山了，风景真美！大自然太治愈啦！',
        images: [
          'https://img0.baidu.com/it/u=2345678901,1098765432&fm=26&fmt=auto&app=138&f=JPEG?w=500&h=375',
          'https://img1.baidu.com/it/u=3456789012,2109876543&fm=26&fmt=auto&app=138&f=JPEG?w=500&h=375'
        ],
        createTime: '2小时前',
        comments: [
          FriendCommentModel(fromUser: '小赵', toUser: '小王', content: '哇，这山好高呀！'),
          FriendCommentModel(
              fromUser: '小王', toUser: '小赵', content: '是呀，爬得我累死了！'),
        ],
        likes: ['小赵', '小张'],
      ),
      MomentModel(
        momentId: 10003,
        userId: 1939140554751221763,
        nickname: '小陈',
        portrait:
            'https://img0.baidu.com/it/u=4567890123,3210987654&fm=26&fmt=auto&app=138&f=JPEG?w=500&h=375',
        content: '新学了一道菜，味道还不错😋',
        images: [
          'https://img0.baidu.com/it/u=5678901234,4321098765&fm=26&fmt=auto&app=138&f=JPEG?w=500&h=375'
        ],
        createTime: '3小时前',
        comments: [
          FriendCommentModel(
              fromUser: '小孙', toUser: '小陈', content: '什么菜呀，快分享下做法！'),
          FriendCommentModel(
              fromUser: '小陈', toUser: '小孙', content: '是红烧肉，网上有教程哦！'),
        ],
        likes: ['小孙', '小李'],
      ),
      MomentModel(
        momentId: 10004,
        userId: 1939140554751221764,
        nickname: '小周',
        portrait:
            'https://img0.baidu.com/it/u=6789012345,5432109876&fm=26&fmt=auto&app=138&f=JPEG?w=500&h=375',
        content: '看了一场超棒的电影，剧情太精彩了👏',
        images: [
          'https://img0.baidu.com/it/u=7890123456,6543210987&fm=26&fmt=auto&app=138&f=JPEG?w=500&h=375'
        ],
        createTime: '4小时前',
        comments: [
          FriendCommentModel(
              fromUser: '小吴', toUser: '小周', content: '什么电影呀？求推荐！'),
          FriendCommentModel(
              fromUser: '小周', toUser: '小吴', content: '《流浪地球2》，强烈推荐！'),
        ],
        likes: ['小吴', '小王'],
      ),
      MomentModel(
        momentId: 10005,
        userId: 1939140554751221765,
        nickname: '小郑',
        portrait:
            'https://img0.baidu.com/it/u=8901234567,7654321098&fm=26&fmt=auto&app=138&f=JPEG?w=500&h=375',
        content: '健身打卡，坚持就是胜利💪',
        images: [
          'https://img0.baidu.com/it/u=9012345678,8765432109&fm=26&fmt=auto&app=138&f=JPEG?w=500&h=375'
        ],
        createTime: '5小时前',
        comments: [
          FriendCommentModel(
              fromUser: '小朱', toUser: '小郑', content: '你好自律呀，向你学习！'),
          FriendCommentModel(fromUser: '小郑', toUser: '小朱', content: '一起加油呀！'),
        ],
        likes: ['小朱', '小陈'],
      ),
      MomentModel(
        momentId: 10006,
        userId: 1939140554751221766,
        nickname: '小胡',
        portrait:
            'https://img0.baidu.com/it/u=0123456789,9876543210&fm=26&fmt=auto&app=138&f=JPEG?w=500&h=375',
        content: '参加了一场音乐会，现场氛围太棒了🎶',
        images: [
          'https://img0.baidu.com/it/u=1234567890,0987654321&fm=26&fmt=auto&app=138&f=JPEG?w=500&h=375'
        ],
        createTime: '6小时前',
        comments: [
          FriendCommentModel(fromUser: '小杨', toUser: '小胡', content: '什么音乐会呀？'),
          FriendCommentModel(
              fromUser: '小胡', toUser: '小杨', content: '是古典音乐会，特别精彩！'),
        ],
        likes: ['小杨', '小周'],
      ),
    ];
  } else if (page == 2) {
    return [
      MomentModel(
        momentId: 10006,
        userId: 1939140554751221766,
        nickname: '小胡N',
        portrait:
            'https://img0.baidu.com/it/u=0123456789,9876543210&fm=26&fmt=auto&app=138&f=JPEG?w=500&h=375',
        content: '参加了一场音乐会，现场氛围太棒了🎶',
        images: [
          'https://img0.baidu.com/it/u=1234567890,0987654321&fm=26&fmt=auto&app=138&f=JPEG?w=500&h=375'
        ],
        createTime: '6小时前',
        comments: [
          FriendCommentModel(fromUser: '小杨', toUser: '小胡', content: '什么音乐会呀？'),
          FriendCommentModel(
              fromUser: '小胡', toUser: '小杨', content: '是古典音乐会，特别精彩！'),
        ],
        likes: ['小杨', '小周'],
      ),
    ];
  } else {
    return [];
  }
}
