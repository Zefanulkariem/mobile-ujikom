import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pubk_mobile2/app/data/profile_response.dart';
import 'package:pubk_mobile2/app/utils/api.dart';

class ProfileController extends GetxController {
  final authToken = GetStorage();
  final _getConnect = GetConnect();
  var profileList = <Map<String, dynamic>>[].obs;
  final String? token = GetStorage().read('token');
  var isLoading = false.obs;

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  Future<ProfileResponse> getProfile() async {
    try {
      final response = await _getConnect.get(BaseUrl.profile,
        headers: {'Authorization': "Bearer $token"},
        contentType: "application/json",
      );

      if (response.statusCode == 200) {
        return ProfileResponse.fromJson(response.body);
      } else {
        throw Exception("Failed to load profile: ${response.statusText}");
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  void logout() {
    authToken.remove('token');
    Get.offAllNamed('/login');
  }
}
