import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pubk_mobile2/app/modules/meeting/controllers/meeting_controller.dart';
import 'package:pubk_mobile2/app/modules/meeting/views/meeting_detail_view.dart';

class MeetingView extends GetView<MeetingController> {
  final MeetingController controller = Get.put(MeetingController()); // Pastikan controller diinisialisasi

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

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  title: Text(meeting['judul'] ?? "Tak Berjudul"),
                  subtitle: Text("Tanggal: ${meeting['tanggal'] ?? '-'}"),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Get.to(() => MeetingDetailView(meeting: meeting));
                  },
                ),
              );
            },
          );
        }),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => controller.fetchMeetings(),
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }
}