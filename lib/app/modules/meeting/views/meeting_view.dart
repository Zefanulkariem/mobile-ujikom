import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pubk_mobile2/app/modules/meeting/controllers/meeting_controller.dart';
import 'package:pubk_mobile2/app/modules/meeting/views/meeting_detail_view.dart';

class MeetingView extends GetView<MeetingController> {
  final MeetingController controller = Get.put(MeetingController());
  MeetingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Meeting")),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.meetingList.isEmpty) {
            return const Center(child: Text("Tidak ada meeting tersedia."));
          }

          return ListView.builder(
            itemCount: controller.meetingList.length,
            itemBuilder: (context, index) {
              final meeting = controller.meetingList[index];

              // return Card(
              //   margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //   child: ListTile(
              //     title: Text(meeting['judul'] ?? "Tak Berjudul"),
              //     subtitle: Text("Tanggal: ${meeting['tanggal'] ?? '-'}"),
              //     trailing: const Icon(Icons.arrow_forward),
              //     onTap: () {
              //       Get.to(() => MeetingDetailView(meeting: meeting));
              //     },
              //   ),
              // );
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                shape: RoundedRectangleBorder( // Untuk membuat sudut melengkung
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding( 
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meeting['judul'] ?? "Tak Berjudul",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        meeting['nama'] ?? "-",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                          const SizedBox(width: 5),
                          Text("Tanggal: ${meeting['tanggal'] ?? '-'}", style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 16, color: Colors.grey),
                          const SizedBox(width: 5),
                          Text("Lokasi: ${meeting['lokasi_meeting'] ?? '-'}", style: const TextStyle(color: Colors.grey)), // Asumsi ada field 'lokasi'
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Aksi ketika tombol "Menunggu Konfirmasi" ditekan
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor('#344767'), // Contoh warna tombol
                            ),
                            child: Text(
                              '— MENUNGGU KONFIRMASI —',
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white
                              )),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(width: 10),
                          OutlinedButton(
                            onPressed: () {
                              Get.to(() => MeetingDetailView(meeting: meeting));
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.orange), // Contoh warna border tombol
                            ),
                            child: const Icon(Icons.visibility, size: 16, color: Colors.orange),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.getMeetings(),
        child: const Icon(Icons.add),
      ),
    );
  }
}