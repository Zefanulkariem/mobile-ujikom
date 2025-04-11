import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pubk_mobile2/app/data/profile_response.dart';
import 'package:pubk_mobile2/app/utils/api.dart';

class ProfileController extends GetxController {
  final authToken = GetStorage();
  final _getConnect = GetConnect();
  final String? token = GetStorage().read('token');
  var isLoading = false.obs;
  
  // Gunakan Rx untuk model ProfileResponse
  final Rx<ProfileResponse?> profile = Rx<ProfileResponse?>(null);

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  Future<void> getProfile() async {
    try {
      isLoading.value = true;
      
      if (token == null) {
        print("Token kosong atau tidak tersedia");
        return;
      }
      
      final response = await _getConnect.get(
        BaseUrl.profile,
        headers: {'Authorization': "Bearer $token"},
        contentType: "application/json",
      );
      
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      
      if (response.status.hasError) {
        print("Error status: ${response.statusCode}");
        print("Error body: ${response.body}");
        return;
      }
      
      // Parsing response body
      dynamic jsonData;
      try {
        if (response.body is String) {
          jsonData = jsonDecode(response.body);
        } else {
          jsonData = response.body;
        }
        
        if (jsonData.containsKey('user')) {
          try {
            if (jsonData['user'] is Map) {
              profile.value = ProfileResponse.fromJson(Map<String, dynamic>.from(jsonData['user']));
              print("Profil berhasil diambil dari key: user");
              return;
            }
          } catch (e) {
            print("Gagal parsing dari key user: $e");
          }
        }

      } catch (e) {
        print("Gagal parsing atau inspeksi JSON: $e");
        return;
      }
      
    } catch (e) {
      print("Error saat mengambil profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    authToken.remove('token');
    Get.offAllNamed('/login');
  }
}