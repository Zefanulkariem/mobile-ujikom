import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pubk_mobile2/app/modules/dashboard/views/index_view.dart';
import 'package:pubk_mobile2/app/modules/dashboard/views/maps_view.dart';
import 'package:pubk_mobile2/app/modules/dashboard/views/operasional_view.dart';
import 'package:pubk_mobile2/app/modules/profile/views/profile_view.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
    IndexView(),
    MapsView(),
    // OperasionalView(),
    ProfileView(),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
