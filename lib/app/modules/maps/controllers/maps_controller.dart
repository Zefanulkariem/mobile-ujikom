import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:pubk_mobile2/app/data/maps_response.dart';
import 'package:pubk_mobile2/app/utils/api.dart';

class MapsController extends GetxController {
  var isLoading = true.obs;
  var markers = <LatLng>[].obs;
  var jmlUserUmkm = 0.obs;
  var jmlLokasiUmkm = 0.obs;
  //TODO: Implement MapsController

  @override
  void onInit() {
    super.onInit();
    fetchUMKM();
    fetchJmlUserUmkm();
    fetchJmlLokasiUmkm();
  }

  Future<void> fetchUMKM() async {
    try {
      print("Fetching data from: ${BaseUrl.maps}");
      
      final response = await http.get(Uri.parse(BaseUrl.maps));

      if (response.statusCode == 200) {
        final result = MapsResponse.fromJson(jsonDecode(response.body));

        if (result.data != null && result.data!.isNotEmpty) {
          markers.assignAll(result.data!.map((umkm) {
            return LatLng(
              _parseCoordinate(umkm.lat),
              _parseCoordinate(umkm.lon),
            );
          }).toList());
          print("Total UMKM: ${markers.length}");
        } else {
          print("No UMKM data found.");
        }
      } else {
        print("Failed to load UMKM data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching UMKM: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchJmlUserUmkm() async {
    try {
      print("Fetching jumlah user UMKM...");  // Cek apakah fungsi ini kepanggil
      final response = await http.get(Uri.parse(BaseUrl.maps));

      print("Response Status jml user UMKM: ${response.statusCode}");  // Cek status response

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // print("Data jml user umkm: $data");  // Cek isi response

        jmlUserUmkm.value = data['jmlUserUmkm'];  // Set manual buat testing. ralat*  gunakan API
        print("Updated jmlUserUmkm: ${jmlUserUmkm.value}");  // Cek apakah berubah
      } else {
        print("Gagal mengambil data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> fetchJmlLokasiUmkm() async {
    try {
      print("Fetching jumlah UMKM...");  // Cek apakah fungsi ini kepanggil
      final response = await http.get(Uri.parse(BaseUrl.maps));

      print("Response Status UMKM: ${response.statusCode}");  // Cek status response

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // print("Data dari API: $data");  // Cek isi response

        jmlLokasiUmkm.value = data['jmlLokasiUmkm'];  // Set manual buat testing. ralat*  gunakan API
        print("Updated jmlUserUmkm: ${jmlLokasiUmkm.value}");  // Cek apakah berubah
      } else {
        print("Gagal mengambil data UMKM: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }


  double _parseCoordinate(String? value) {
    return double.tryParse(value ?? '') ?? 0.0;
  }


}
