import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pubk_mobile2/app/modules/meeting/controllers/meeting_controller.dart';
import 'package:pubk_mobile2/app/modules/meeting/views/meeting_add_view.dart';
import 'package:pubk_mobile2/app/modules/meeting/views/meeting_detail_view.dart';

class MeetingView extends GetView<MeetingController> {
  final MeetingController meetingController = Get.find();
  MeetingView({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = HexColor('#6750A4');
    final secondaryColor = HexColor('#344767');
    final warningColor = HexColor('#F5365C');
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(
          "Daftar Meeting",
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(
        //       Icons.filter_list,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {
        //       Get.snackbar(
        //         'Filter', 
        //         'Filter meeting',
        //         snackPosition: SnackPosition.BOTTOM,
        //       );
        //     },
        //   ),
        // ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Cari meeting...",
                      hintStyle: GoogleFonts.montserrat(color: Colors.white.withOpacity(0.7)),
                      prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.7)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      controller.searchMeetings(value);
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 10),
            
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: Row(
            //     children: [
            //       _buildStatusTab("Semua", true, primaryColor),
            //       _buildStatusTab("Menunggu", false, primaryColor),
            //       _buildStatusTab("Terkonfirmasi", false, primaryColor),
            //       _buildStatusTab("Selesai", false, primaryColor),
            //     ],
            //   ),
            // ),
            
            const SizedBox(height: 10),
            
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }

                if (controller.meetingList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_busy,
                          size: 70,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Tidak ada meeting tersedia",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.refresh),
                          label: const Text("Muat Ulang"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () => controller.getMeetings(),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: controller.filteredMeetingList.length,
                  itemBuilder: (context, index) {
                    final meeting = controller.filteredMeetingList[index];
                    
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Get.to(() => MeetingDetailView(meeting: meeting));
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: secondaryColor.withOpacity(0.05),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      meeting['judul'] ?? "Tak Berjudul",
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: secondaryColor,
                                        ),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: statusColor(meeting['status_verifikasi']).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: statusColor(meeting['status_verifikasi']),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      '${meeting['status_verifikasi'] ?? 'Menunggu'}',
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: statusColor(meeting['status_verifikasi']),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Icon(
                                          Icons.store,
                                          color: Colors.orange,
                                          size: 18,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "UMKM",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            Text(
                                              meeting['umkm']?['name'] ?? "Loading...",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  const SizedBox(height: 12),
                                  
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                meeting['tanggal'] ?? '-',
                                                style: GoogleFonts.montserrat(color: Colors.grey[700]),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                meeting['lokasi_meeting'] ?? '-',
                                                style: GoogleFonts.montserrat(color: Colors.grey[700]),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  const SizedBox(height: 16),
                                  
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (meeting['investor'] != null)
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.person,
                                                size: 16,
                                                color: Colors.blue[700],
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                child: Text(
                                                  "Diajukan oleh: ${meeting['investor']?['name'] ?? '-'}",
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: Colors.blue[700],
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ElevatedButton.icon(
                                        icon: const Icon(Icons.delete, size: 16),
                                        label: const Text('Hapus'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: warningColor,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          textStyle: const TextStyle(fontSize: 12),
                                        ),
                                        onPressed: () {
                                          Get.dialog(
                                            AlertDialog(
                                              title: Text(
                                                'Hapus',
                                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                                              ),
                                              content: Text(
                                                'Apakah Anda yakin ingin hapus data ini?',
                                                style: GoogleFonts.poppins(),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Get.back(),
                                                  child: Text(
                                                    'Batal',
                                                    style: GoogleFonts.poppins(color: Colors.grey),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    meetingController.deleteMeeting(meeting['id']);
                                                    Get.back();
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: primaryColor,
                                                    foregroundColor: Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Hapus',
                                                    style: GoogleFonts.poppins(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Get.to(() => MeetingAddView());
        },
      ),
    );
  }
  
  Widget _buildStatusTab(String label, bool isActive, Color primaryColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isActive ? primaryColor : Colors.grey[300]!,
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : Colors.grey[600],
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
  
  Color statusColor(String? status) {
    switch (status) {
      case 'Disetujui':
        return Colors.green;
      case 'Ditolak':
        return Colors.red;
      case 'Menunggu':
      default:
        return Colors.orange;
    }
  }
}