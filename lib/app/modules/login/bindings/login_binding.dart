import 'package:get/get.dart';
import 'package:pubk_mobile2/app/modules/meeting/controllers/meeting_controller.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut(
      () => MeetingController()
    );
  }
}
