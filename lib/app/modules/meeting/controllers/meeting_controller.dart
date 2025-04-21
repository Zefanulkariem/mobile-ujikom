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

  var searchQuery = ''.obs;
  var filteredMeetingList = <Map<String, dynamic>>[].obs;

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
      // print("Fetching data meetings...");
      // print("Base URL: ${BaseUrl.meeting}");
      // print("Token yang diambil di fetchMeetings() ke MEETING: $token");
      // print("Token yang dikirim MEETING: $token");

      var response = await http.get(
        Uri.parse(BaseUrl.meeting),
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
      );

      // print("Response Status MEETING: ${response.statusCode}");
      // print("Response Body MEETING: ${response.body}");

      if (response.statusCode == 200) {
        try {
          var jsonData = jsonDecode(response.body);

          if (jsonData is Map) {
            if (jsonData.containsKey("name")) {
              userName.value = jsonData["name"];
              // print("Data username berhasil dimuat: ${userName.value}");
            }

            if (jsonData.containsKey("data")) {
              meetingList.assignAll(
                  (jsonData["data"] as List).cast<Map<String, dynamic>>());
              // print("Data meeting berhasil dimuat: ${response.body} item");
              filteredMeetingList.assignAll(meetingList);
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

  Future<void> addMeeting({
    required int idInvestor,
    required int idUmkm,
    required String judul,
    required String lokasiMeeting,
    required String tanggal,
  }) async {
    isLoading.value = true;

    try {
      var response = await http.post(
        Uri.parse(BaseUrl.meeting),
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "id_investor": idInvestor,
          "id_umkm": idUmkm,
          "judul": judul,
          "lokasi_meeting": lokasiMeeting,
          "tanggal": tanggal,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData["data"] != null) {
          meetingList.add(jsonData["data"]);
          // Get.snackbar("Sukses", "Meeting berhasil ditambahkan");
          await Future.delayed(Duration(seconds: 3));
          await getMeetings();
          Get.back();
        } else {
          Get.snackbar("Gagal","Meeting berhasil ditambahkan, tapi tidak ada data baru.");
        }

      } else {
        Get.snackbar(
            "Error", "Gagal menambahkan meeting: ${response.statusCode}");
      }
    } catch (e) {
      print("Error saat menambahkan meeting: $e");
      Get.snackbar("Error", "Terjadi kesalahan");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteMeeting(int id) async {
  try {
    var response = await http.delete(
      Uri.parse("${BaseUrl.meeting}/$id"),
      headers: {
        'Authorization': "Bearer $token",
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      Get.snackbar("Sukses", "Meeting berhasil dihapus");

      meetingList.removeWhere((item) => item["id"] == id);
      await getMeetings();
      } else {
        Get.snackbar("Error", "Gagal menghapus meeting: ${response.statusCode}");
      }
    } catch (e) {
      print("Error saat menghapus meeting: $e");
      Get.snackbar("Error", "Terjadi kesalahan");
    }
  }

  void searchMeetings(String query) {
    searchQuery.value = query;
    
    if (query.isEmpty) {
      filteredMeetingList.assignAll(meetingList);

    } else {

      filteredMeetingList.assignAll(meetingList.where((meeting) {
        final judul = meeting['judul']?.toString().toLowerCase() ?? '';
        final pemilikUmkm = meeting['umkm']?['name']?.toString().toLowerCase() ?? '';
        final lokasi = meeting['lokasi_meeting']?.toString().toLowerCase() ?? '';
        final tanggal = meeting['tanggal']?.toString().toLowerCase() ?? '';
        final status = meeting['status_verifikasi']?.toString().toLowerCase() ?? '';
        
        return judul.contains(query.toLowerCase()) || 
              pemilikUmkm.contains(query.toLowerCase()) ||
              lokasi.contains(query.toLowerCase()) ||
              tanggal.contains(query.toLowerCase()) ||
              status.contains(query.toLowerCase());
      }).toList());
    }
  }
}
