import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pubk_mobile2/app/modules/meeting/controllers/meeting_controller.dart';

class MeetingDetailView extends GetView<MeetingController> {
  final Map<String, dynamic> meeting; 
  const MeetingDetailView({super.key, required this.meeting});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Meeting")
        ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // judul
            Text("Judul: ${meeting['judul'] ?? '-'}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Tanggal: ${meeting['tanggal'] ?? '-'}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            // lokasi
            Text("Lokasi:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(meeting['lokasi_meeting'] ?? "Tidak ada lokasi."),
            SizedBox(height: 10),
            // pengaju
            Text("Di Ajukan oleh:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Obx(() => Text(controller.userName.value.isEmpty ? "Loading..." : controller.userName.value)),
          ],
        ),
      ),
    );
  }
}
