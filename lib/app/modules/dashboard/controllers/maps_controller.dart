import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:pubk_mobile2/app/data/maps_response.dart';
import 'package:pubk_mobile2/app/utils/api.dart';

class MapsController extends GetxController {
  var isLoading = true.obs;
  var markers = <LatLng>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUMKM();
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

  double _parseCoordinate(String? value) {
    return double.tryParse(value ?? '') ?? 0.0;
  }
}
