import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pubk_mobile2/app/modules/maps/controllers/maps_controller.dart';
import 'package:pubk_mobile2/app/modules/meeting/controllers/meeting_controller.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  Get.lazyPut(() => MapsController());
  Get.lazyPut(() => MeetingController());
  runApp(
    GetMaterialApp(
      title: "PUBK - Mobile",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
