import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/tools/tools_sqlite.dart';

class GroupQrCodeController extends BaseController {
  late ChatGroup chatGroup;
  @override
  void onInit() {
    super.onInit();
    chatGroup = Get.arguments;
  }
}
