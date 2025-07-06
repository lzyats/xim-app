import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_common.dart';

class CommonNoticesController extends BaseController {
  // 下拉刷新
  void onRefresh() {
    superRefresh(
      RequestCommon.getNoticeList(1),
    );
  }

  // 上滑加载
  void onLoading() {
    superLoading(
      RequestCommon.getNoticeList(refreshPageIndex + 1),
    );
  }

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }
}
