import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:latlong2/latlong.dart';
import 'package:pubk_mobile2/app/modules/maps/controllers/maps_controller.dart';

class MapsView extends GetView<MapsController> {
  const MapsView({super.key});

  @override
  Widget build(BuildContext context) {
    final PopupController popupController = PopupController();
    final primaryColor = HexColor('#2E7A35');

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(
          'Peta',
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.notifications_outlined),
        //     onPressed: () {
        //       Get.snackbar(
        //         'Notifikasi', 
        //         'Fitur notifikasi akan segera hadir',
        //         snackPosition: SnackPosition.BOTTOM,
        //       );
        //     },
        //   ),
        // ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return FlutterMap(
          options: MapOptions(
            initialCenter: const LatLng(-6.914744, 107.609810),
            initialZoom: 12,
            onTap: (_, __) => popupController.hideAllPopups(),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: controller.markers.map((point) {
                return Marker(
                  point: point,
                  width: 30,
                  height: 30,
                  child: GestureDetector(
                    onTap: () {
                      popupController.togglePopup(
                        Marker(
                          point: point,
                          width: 30,
                          height: 30,
                          child: const Icon(Icons.location_on, color: Colors.red, size: 30),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 30.0,
                    ),
                  ),
                );
              }).toList(),
            ),
            PopupMarkerLayer(
              options: PopupMarkerLayerOptions(
                popupController: popupController,
                markers: controller.markers.map((point) {
                  return Marker(
                    point: point,
                    width: 30,
                    height: 30,
                    child: const Icon(Icons.location_on, color: Colors.red, size: 30),
                  );
                }).toList(),
                // popupBuilder: (context, marker) {
                //   return Card(
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Column(
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           const Text(
                //             "Detail UMKM",
                //             style: TextStyle(fontWeight: FontWeight.bold),
                //           ),
                //           Text("Lat: ${marker.point.latitude}"),
                //           Text("Lon: ${marker.point.longitude}"),
                //           TextButton(
                //             onPressed: () {
                //               Get.toNamed('/detail-umkm', arguments: marker.point);
                //             },
                //             child: const Text("Selengkapnya"),
                //           ),
                //         ],
                //       ),
                //     ),
                //   );
                // },
              ),
            ),
          ],
        );
      }),
    );
  }
}
