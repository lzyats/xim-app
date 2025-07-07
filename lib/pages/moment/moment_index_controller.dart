// package:alpaca/pages/moment/moment_index_controller.dart
import 'package:get/get.dart';
import 'package:alpaca/request/request_moment.dart';
import 'package:alpaca/tools/tools_comment.dart';

class MomentIndexController extends GetxController {
  // 添加 isLoading 状态
  final RxBool isLoading = true.obs;

  // 朋友圈列表
  RxList<MomentModel> momentList = <MomentModel>[].obs;
  // 当前页码
  int pageNum = 1;
  // 每页数量
  int pageSize = 10;

  // 获取朋友圈列表
  Future<void> getMomentList() async {
    try {
      // 调用请求方法获取朋友圈列表
      List<MomentModel> newList =
          await RequestMoment.getMomentList(pageNum, pageSize);
      // 将新数据添加到列表中
      momentList.addAll(newList);
      // 页码加1，以便下次加载下一页数据
      pageNum++;
    } catch (e) {
      print('获取朋友圈列表失败: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    // 初始化时获取第一页朋友圈数据
    getMomentList();
  }

  // 点赞/取消点赞
  Future<void> toggleLike(String momentId) async {
    try {
      // 找到对应的朋友圈项
      final momentIndex = momentList.indexWhere((m) => m.momentId == momentId);
      if (momentIndex == -1) return;

      // 获取当前状态
      final currentMoment = momentList[momentIndex];
      final isLiked = currentMoment.isLiked;

      // 更新本地状态
      final updatedMoment = currentMoment.copyWith(
        isLiked: !isLiked,
        likeCount:
            isLiked ? currentMoment.likeCount - 1 : currentMoment.likeCount + 1,
      );

      // 更新列表
      momentList[momentIndex] = updatedMoment;

      // 调用API
      if (isLiked) {
        // 取消点赞
        await MomentService.unlikeMoment(momentId);
      } else {
        // 点赞
        await MomentService.likeMoment(momentId);
      }
    } catch (e) {
      print('点赞操作失败: $e');
      // 操作失败时恢复状态
      refreshMoments();
    }
  }
}
