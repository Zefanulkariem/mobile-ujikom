import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pubk_mobile2/app/modules/maps/controllers/maps_controller.dart';
import 'package:pubk_mobile2/app/modules/meeting/controllers/meeting_controller.dart';

class IndexView extends GetView<MeetingController> {
  // final Map<String, dynamic> meeting;
  const IndexView({super.key, // required this.meeting
  });

  @override
  Widget build(BuildContext context) {
    final MapsController controllerMaps = Get.put(MapsController());
    final MeetingController controllerMeet = Get.put(MeetingController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dasbor'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 46, 122, 53),
              ),
              child: Text(
                'PUBK - Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Beranda'),
              onTap: () {
                Get.back(); // Tutup drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {
                Get.back(); // Tutup drawer
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'SELAMAT DATANG KEMBALI!',
              style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 17,
              )),
              textAlign: TextAlign.start,
            ),
            Obx(() => Text(
                  controllerMeet.userName.value.isEmpty
                      ? "Loading..."
                      : controllerMeet.userName.value,
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  textAlign: TextAlign.start,
                )),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: <Widget>[
                Obx(() => _buildDashboardCard(
                      title: 'Jumlah UMKM Saat Ini',
                      icon: Icons.location_on,
                      value: controllerMaps.jmlLokasiUmkm.toString(),
                      onTap: () {
                        // Tambahkan aksi ketika card ditekan
                        print('Jumlah UMKM Ditekan');
                      },
                    )),
                Obx(() => _buildDashboardCard(
                      title: 'Total Pemilik UMKM Saat Ini',
                      icon: Icons.shopping_cart,
                      value: controllerMaps.jmlUserUmkm.toString(),
                      onTap: () {
                        // Tambahkan aksi ketika card ditekan
                        print('Total Pemilik UMKM Ditekan');
                      },
                    )),
                // _buildDashboardCard(
                //   title: 'Pendapatan',
                //   icon: Icons.monetization_on,
                //   value: 'Rp 1.000.000',
                //   onTap: () {
                //     // Tambahkan aksi ketika card ditekan
                //     print('Pendapatan Ditekan');
                //   },
                // ),
                // Tambahkan card-card lain sesuai kebutuhan
              ],
            ),
            const SizedBox(height: 20),
            // Card(
            //   elevation: 4,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Padding(
            //     padding: EdgeInsets.all(16.0),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         const Text(
            //           'Daftar Jadwal Meeting',
            //           style:
            //               TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //         ),
            //         const SizedBox(height: 10),
            //         // Di sini Anda bisa menambahkan widget untuk menampilkan grafik
            //         // Contoh: Placeholder untuk grafik
            //         Container(
            //           height: 200,
            //           // color: Colors.grey[200],
            //           child: Column(
            //             children: [
            //               Text("Judul: ${meeting['judul'] ?? '-'}",
            //                   style: const TextStyle(
            //                       fontSize: 16, fontWeight: FontWeight.bold)),
            //               const SizedBox(height: 10),
            //               Text("Tanggal: ${meeting['tanggal'] ?? '-'}",
            //                   style: const TextStyle(fontSize: 16)),
            //               const SizedBox(height: 10),
            //               Text("Lokasi: ${meeting['lokasi_meeting'] ?? '-'}",
            //                   style: const TextStyle(
            //                       fontSize: 16, fontWeight: FontWeight.bold)),
            //               // const SizedBox(height: 5),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
            Text(
              "© Pusat Usaha Bersama dan Kemitraan ${DateTime.now().year}. All rights reserved.",
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
              selectionColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required String title,
    required IconData icon,
    required String value,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 40, color: const Color.fromARGB(255, 46, 122, 53)),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
