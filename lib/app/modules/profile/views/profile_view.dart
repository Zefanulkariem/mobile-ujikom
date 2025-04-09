import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pubk_mobile2/app/modules/profile/controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ProfileView is working',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Get.defaultDialog(
                  backgroundColor: Colors.white,
                  titleStyle: TextStyle(color: Colors.black),
                  title: 'Apakah Yakin ingin Logout?',
                  textCancel: "Batal",
                  cancelTextColor: Colors.black,
                  textConfirm: "Konfirmasi",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    controller.logout();
                    Get.back();
                  },
                  onCancel: () {
                  Get.back();
                },
              );
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      )
    );
  }
}
