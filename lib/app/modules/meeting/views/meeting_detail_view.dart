import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pubk_mobile2/app/modules/meeting/controllers/meeting_controller.dart';

class MeetingDetailView extends GetView<MeetingController> {
  final Map<String, dynamic> meeting;
  const MeetingDetailView({super.key, required this.meeting});
  
  @override
  Widget build(BuildContext context) {
    // Tema warna utama
    final primaryColor = HexColor('#6750A4');
    final secondaryColor = HexColor('#344767');
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(
          "Detail Meeting",
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header dengan judul meeting
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meeting['judul'] ?? "Meeting Tanpa Judul",
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Informasi utama dalam Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildInfoItem(
                        context,
                        Icons.calendar_today,
                        "Tanggal",
                        meeting['tanggal'] ?? "Tidak ada tanggal.",
                        primaryColor,
                      ),
                      const Divider(),
                      _buildInfoItem(
                        context,
                        Icons.location_on,
                        "Lokasi",
                        meeting['lokasi_meeting'] ?? "Tidak ada lokasi.",
                        primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Informasi peserta
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Peserta Meeting",
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildParticipantItem(
                        context,
                        "Investor",
                        meeting['investor']?['name'] ?? "Loading...",
                        Icons.business,
                        secondaryColor,
                      ),
                      const SizedBox(height: 12),
                      _buildParticipantItem(
                        context,
                        "Pemilik UMKM",
                        meeting['umkm']?['name'] ?? "Loading...",
                        Icons.store,
                        Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Informasi tambahan
            if (meeting['deskripsi'] != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Deskripsi",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          meeting['deskripsi'] ?? "Tidak ada deskripsi.",
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
            const SizedBox(height: 24),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.grey.withOpacity(0.2),
      //         spreadRadius: 1,
      //         blurRadius: 5,
      //       ),
      //     ],
      //   ),
      //   child: Row(
      //     children: [
      //       Expanded(
      //         child: ElevatedButton.icon(
      //           icon: const Icon(Icons.check_circle),
      //           label: const Text("Konfirmasi Meeting"),
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: primaryColor,
      //             foregroundColor: Colors.white,
      //             padding: const EdgeInsets.symmetric(vertical: 12),
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(10),
      //             ),
      //           ),
      //           onPressed: () {
      //             // Implementasi konfirmasi meeting
      //             Get.snackbar(
      //               'Konfirmasi', 
      //               'Meeting berhasil dikonfirmasi',
      //               snackPosition: SnackPosition.BOTTOM,
      //               backgroundColor: Colors.green,
      //               colorText: Colors.white,
      //             );
      //           },
      //         ),
      //       ),
      //       const SizedBox(width: 10),
      //       ElevatedButton.icon(
      //         icon: const Icon(Icons.edit),
      //         label: const Text("Edit"),
      //         style: ElevatedButton.styleFrom(
      //           backgroundColor: Colors.white,
      //           foregroundColor: primaryColor,
      //           padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(10),
      //             side: BorderSide(color: primaryColor),
      //           ),
      //         ),
      //         onPressed: () {
      //           // Implementasi edit meeting
      //           Get.snackbar(
      //             'Edit', 
      //             'Mengedit detail meeting',
      //             snackPosition: SnackPosition.BOTTOM,
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
  
  Widget _buildInfoItem(BuildContext context, IconData icon, String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildParticipantItem(BuildContext context, String role, String name, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                role,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}