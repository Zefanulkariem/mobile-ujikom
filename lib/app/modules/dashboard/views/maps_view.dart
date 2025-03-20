import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:pubk_mobile2/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:pubk_mobile2/app/modules/dashboard/controllers/maps_controller.dart';

class MapsView extends GetView<MapsController> {
  const MapsView({super.key});

  @override
  Widget build(BuildContext context) {
  Get.to(() => MapsView(), binding: DashboardBinding());
    return Scaffold(
      appBar: AppBar(
        title: Text("Peta UMKM"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Balik ke halaman sebelumnya
          },
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(-6.914744, 107.609810), // Titik awal (Bandung)
            initialZoom: 12,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: controller.markers.map((coord) {
                return Marker(
                  width: 40.0,
                  height: 40.0,
                  point: coord,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 30.0,
                  ),
                );
              }).toList(),
            ),
          ],
        );
      }),
    );
  }
}
