import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pubk_mobile2/app/modules/dashboard/views/dashboard_view.dart';
import 'package:pubk_mobile2/app/utils/api.dart';

class LoginController extends GetxController {
  final _getConnect = GetConnect();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final authToken = GetStorage();

  void loginNow() async {
    final response = await _getConnect.post(BaseUrl.login, {
      'email': emailController.text,
      'password': passwordController.text,
    });

    // print("Response dari API: ${response.body}");

    if (response.statusCode == 200) {
      String token = response.body['access_token'];
      authToken.write('token', token);

      // authToken.write('id_investor', response.body['investor']['id']);
      // if (response.body['id_investor'] != null) {
      //   authToken.write('userId', response.body['user']['id']);
      //   print("User ID tersimpan: ${authToken.read('userId')}");
      // }

      print("Token setelah login: ${GetStorage().read('token')}");// Cek token 
      Get.offAll(() => const DashboardView());
    } else {
      print("Gagal login: ${response.body}");
      Get.snackbar(
        'Terjadi Kesalahan',
        'Harap isi data dengan benar',
        icon: const Icon(Icons.error),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        forwardAnimationCurve: Curves.bounceIn,
        margin: const EdgeInsets.only(
          top: 10,
          left: 5,
          right: 5,
        ),
      );
    }
  }

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
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
