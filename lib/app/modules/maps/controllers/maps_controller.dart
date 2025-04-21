import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:pubk_mobile2/app/data/maps_response.dart';
import 'package:pubk_mobile2/app/utils/api.dart';

class MapsController extends GetxController {
  var isLoading = true.obs;
  var markers = <LatLng>[].obs;
  var umkmList = <UMKMData>[].obs;
  var jmlUserUmkm = 0.obs;
  var jmlLokasiUmkm = 0.obs;
  String? selectedKecamatan = 'Semua';
  List<UMKMData> filteredUmkmList = [];
  List<Marker> popupMarkers = [];

  @override
  void onInit() {
    super.onInit();
    fetchUMKM();
    fetchJmlUserUmkm();
    fetchJmlLokasiUmkm();
    filteredUmkmList = umkmList;
    updateMapMarkers();
  }

  Future<void> fetchUMKM() async {
    try {
      print("Fetching data from: ${BaseUrl.maps}");

      final response = await http.get(Uri.parse(BaseUrl.maps));

      if (response.statusCode == 200) {
        final tampil = MapsResponse.fromJson(jsonDecode(response.body));

        if (tampil.data != null && tampil.data!.isNotEmpty) {
          umkmList.assignAll(tampil.data!);
          markers.assignAll(tampil.data!.map((umkm) {
            return LatLng(
              _parseCoordinate(umkm.lat),
              _parseCoordinate(umkm.lon),
            );
          }).toList());
          // print("Total UMKM: ${markers.length}");
        } else {
          print("No UMKM data found.");
        }
        // ambil data baru
        filteredUmkmList = umkmList;
        updateMapMarkers();  // Perbarui marker setelah data diambil
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
      // print("Fetching jumlah user UMKM...");
      final response = await http.get(Uri.parse(BaseUrl.maps));

      // print("Response Status jml user UMKM: ${response.statusCode}");

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // print("Data jml user umkm: $data");

        jmlUserUmkm.value = data['jmlUserUmkm'];
        // print("Updated jmlUserUmkm: ${jmlUserUmkm.value}");
      } else {
        print("Gagal mengambil data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> fetchJmlLokasiUmkm() async {
    try {
      // print("Fetching jumlah UMKM...");
      final response = await http.get(Uri.parse(BaseUrl.maps));

      // print("Response Status UMKM: ${response.statusCode}");

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // print("Data dari API: $data");

        jmlLokasiUmkm.value = data['jmlLokasiUmkm'];
        // print("Updated jmlUserUmkm: ${jmlLokasiUmkm.value}");
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

  void updateSelectedKecamatan(String? kecamatan) {
    selectedKecamatan = kecamatan;
    update();
  }

  void filterUmkmByKecamatan(String? kecamatan) {
    if (kecamatan == null || kecamatan == 'Semua') {
      filteredUmkmList = umkmList; // Tampilkan semua data
    } else {
      filteredUmkmList = umkmList
          .where(
              (umkm) => umkm.kecamatan.toLowerCase() == kecamatan.toLowerCase())
          .toList();
    }
    // Perbarui marker pada peta
    updateMapMarkers();
    update();
  }

  void updateMapMarkers() {
    // Pastikan filteredUmkmList sudah diinisialisasi
    if (filteredUmkmList.isEmpty) {
      filteredUmkmList = umkmList;
    }

    // Perbaikan pada syntax map dan toList
    popupMarkers = filteredUmkmList.map((umkm) {
      return Marker(
        point: LatLng(double.parse(umkm.lat), double.parse(umkm.lon)),
        width: 40,
        height: 40,
        child: const Icon(
          Icons.location_on,
          color: Colors.red,
          size: 40,
        ),
      );
    }).toList();

    update();
  }
}
