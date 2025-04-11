import 'package:get/get.dart';
import 'package:pubk_mobile2/app/modules/maps/controllers/maps_controller.dart';
import 'package:pubk_mobile2/app/modules/meeting/controllers/meeting_controller.dart';
import 'package:pubk_mobile2/app/modules/profile/controllers/profile_controller.dart';


import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapsController>(
      () => MapsController(),
    );
    Get.lazyPut<MeetingController>(
      () => MeetingController(),
    );
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
