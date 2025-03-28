import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pubk_mobile2/app/modules/meeting/controllers/meeting_controller.dart';

class MeetingDetailView extends GetView<MeetingController> {
  final Map<String, dynamic> meeting; 
  const MeetingDetailView({super.key, required this.meeting});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(meeting['title'] ?? "Detail Meeting")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Judul: ${meeting['title'] ?? '-'}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Tanggal: ${meeting['date'] ?? '-'}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Deskripsi:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(meeting['description'] ?? "Tidak ada deskripsi."),
          ],
        ),
      ),
    );
  }
}
