import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:latlong2/latlong.dart';
import 'package:pubk_mobile2/app/data/maps_response.dart';
import 'package:pubk_mobile2/app/modules/maps/controllers/maps_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class MapsView extends GetView<MapsController> {
  const MapsView({super.key});

  @override
  Widget build(BuildContext context) {
    final PopupController popupController = PopupController();
    final primaryColor = HexColor('#2E7A35');

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(
          'Peta',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final List<Marker> popupMarkers = List.generate(
          controller.umkmList.length,
          (index) {
            final umkm = controller.umkmList[index];
            return Marker(
              point: LatLng(
                double.parse(umkm.lat),
                double.parse(umkm.lon),
              ),
              width: 30,
              height: 30,
              child: const Icon(Icons.location_on, color: Colors.red, size: 30),
            );
          },
        );

        return FlutterMap(
          options: MapOptions(
            initialCenter: const LatLng(-6.914744, 107.609810),
            initialZoom: 12,
            minZoom: 10,
            maxZoom: 18,
            onTap: (_, __) => popupController.hideAllPopups(),
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all  & ~InteractiveFlag.rotate, //control map
            ),
            cameraConstraint: CameraConstraint.contain(
              bounds: LatLngBounds(
                const LatLng(-6.796101, 107.257445), // Southwest corner
                const LatLng(-7.402902, 107.833103), // Northeast corner
              ),
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            // Positioned(
            //   top: 10,
            //   right: 10,
            //   child: _buildKecamatanFilter(),
            // ),
            PopupMarkerLayer(
              options: PopupMarkerLayerOptions(
                popupController: popupController,
                markers: popupMarkers,
                popupDisplayOptions: PopupDisplayOptions(
                  builder: (BuildContext context, Marker marker) {
                    final umkm = controller.filteredUmkmList.firstWhere(
                      (data) =>
                          double.parse(data.lat) == marker.point.latitude &&
                          double.parse(data.lon) == marker.point.longitude,
                      orElse: () => UMKMData(
                        id: 0,
                        lat: '0',
                        lon: '0',
                        desa: 'Data tidak ditemukan',
                        kecamatan: 'Data tidak ditemukan',
                        deskripsi: 'Data tidak ditemukan',
                        image: 'Data tidak ditemukan',
                        namaPemilik: 'Data tidak ditemukan',
                        kelamin: 'Data tidak ditemukan',
                        namaUmkm: 'Data tidak ditemukan',
                        jenisUmkm: 'Data tidak ditemukan',
                        link: '',
                        keuangan: [],
                      ),
                    );

                    return Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (umkm.image != null && umkm.image.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  umkm.image,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            const SizedBox(height: 8),
                            const Text(
                              "Detail UMKM",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Pemilik: ${umkm.namaPemilik}"),
                            Text("Gender: ${umkm.kelamin}"),
                            Text("Pemilik: ${umkm.namaPemilik}"),
                            Text("Desa: ${umkm.desa}"),
                            Text("Kecamatan: ${umkm.kecamatan}"),
                            Text("Kategori UMKM: ${umkm.jenisUmkm}"),
                            TextButton(
                              onPressed: () async {
                                if (umkm.link.isNotEmpty) {
                                  final Uri url = Uri.parse(umkm.link);
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  } else {
                                    // Tampilkan pesan error jika URL tidak bisa dibuka
                                    Get.snackbar('Error', 'Tidak dapat membuka link');
                                  }
                                }
                              },
                              child: const Text("Selengkapnya"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildKecamatanFilter() {
  final kecamatanList = [
    'Semua',
    'Baleendah',
    'Bojongsoang',
    'Cileunyi',
    'Dayeuhkolot',
    'Margahayu',
    'Margaasih',
    'Katapang',
    'Soreang',
    'Cimenyan',
    'Cicalengka',
  ];
  
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: DropdownButton<String>(
      value: controller.selectedKecamatan ?? 'Semua',
      hint: Text('Pilih Kecamatan'),
      underline: SizedBox(),
      onChanged: (String? newValue) {
        // Perbarui status pilihan kecamatan
        controller.updateSelectedKecamatan(newValue);
        // Filter marker berdasarkan kecamatan yang dipilih
        controller.filterUmkmByKecamatan(newValue);
      },
      items: kecamatanList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
  );
}
}