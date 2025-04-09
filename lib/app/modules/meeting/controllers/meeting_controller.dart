import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:pubk_mobile2/app/utils/api.dart';

class MeetingController extends GetxController {
  var meetingList = <Map<String, dynamic>>[].obs;
  final String? token = GetStorage().read('token'); //cek null
  var isLoading = false.obs;
  var userName = ''.obs;

  @override
  void onInit() {
    getMeetings(); 
    super.onInit();
  }

  Future<void> getMeetings() async {
    if (token == null) {
      print("TOKEN KOSONG! Cek apakah sudah login.");
      return;
    }

    try {
      isLoading.value = true;
      // Cek token
      print("Fetching data meetings...");
      print("Base URL: ${BaseUrl.meeting}");
      print("Token yang diambil di fetchMeetings() ke MEETING: $token");
      print("Token yang dikirim MEETING: $token");

      var response = await http.get(
        Uri.parse(BaseUrl.meeting),
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
      );

      print("Response Status MEETING: ${response.statusCode}");
      print("Response Body MEETING: ${response.body}");

      if (response.statusCode == 200) {
        try {
          var jsonData = jsonDecode(response.body);

          if (jsonData is Map) {
            if (jsonData.containsKey("name")) {
              userName.value = jsonData["name"];
              print("Data username berhasil dimuat: ${userName.value}");
            }

            if (jsonData.containsKey("data")) {
              meetingList.assignAll((jsonData["data"] as List).cast<Map<String, dynamic>>());
              print("Data meeting berhasil dimuat: ${meetingList.length} item");
            }
          } else {
            print("Format data tidak sesuai: $jsonData");
          }
        } catch (e) {
          print("Error parsing JSON: $e");
        }
      } else {
        print("Gagal fetch data: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
