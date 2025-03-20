import 'package:get/get.dart';

import 'package:pubk_mobile2/app/modules/dashboard/controllers/maps_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapsController>(
      () => MapsController(),
    );
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
  }
}
