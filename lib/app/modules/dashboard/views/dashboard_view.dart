import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pubk_mobile2/app/modules/dashboard/controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: controller.pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            controller.changeIndex(index);
          },
          selectedItemColor: Colors.black, // Warna item yang dipilih
          unselectedItemColor: Colors.grey, // Warna item yang tidak dipilih
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dasbor'),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Peta'),
            BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Meeting'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}
