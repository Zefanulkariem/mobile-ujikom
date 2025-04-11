import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pubk_mobile2/app/modules/maps/controllers/maps_controller.dart';
import 'package:pubk_mobile2/app/modules/meeting/controllers/meeting_controller.dart';
import 'package:pubk_mobile2/app/modules/meeting/views/meeting_view.dart';

class IndexView extends GetView<MeetingController> {
  const IndexView({super.key});

  @override
  Widget build(BuildContext context) {
    final MapsController controllerMaps = Get.put(MapsController());
    final MeetingController controllerMeet = Get.put(MeetingController());
    final primaryColor = HexColor('#2E7A35');
    final secondaryColor = HexColor('#344767');
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(
          'Dasbor',
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
      body: RefreshIndicator(
        color: primaryColor,
        onRefresh: () async {
          // await controllerMaps.refreshData();
          await controllerMeet.getMeetings();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Section with Gradient
              Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SELAMAT DATANG KEMBALI!',
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Obx(() => Text(
                      controllerMeet.userName.value.isEmpty
                          ? "Loading..."
                          : controllerMeet.userName.value,
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    )),
                    const SizedBox(height: 15),
                    
                    // Quick Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildQuickActionButton(
                          icon: Icons.map,
                          label: 'Peta',
                          onTap: () {
                            Get.toNamed('/maps');
                          },
                        ),
                        _buildQuickActionButton(
                          icon: Icons.people,
                          label: 'Meeting',
                          onTap: () {
                            Get.to(() => MeetingView());
                          },
                        ),
                        _buildQuickActionButton(
                          icon: Icons.store,
                          label: 'UMKM',
                          onTap: () {
                            Get.toNamed('/umkm');
                          },
                        ),
                        _buildQuickActionButton(
                          icon: Icons.settings,
                          label: 'Pengaturan',
                          onTap: () {
                            Get.toNamed('/settings');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Main Content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Title for Statistics
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Statistik PUBK',
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: secondaryColor,
                              ),
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              // controllerMaps.refreshData();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.refresh,
                                    size: 16,
                                    color: primaryColor,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Refresh',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Statistics Cards
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.2,
                      children: <Widget>[
                        Obx(() => _buildStatisticCard(
                          title: 'Jumlah UMKM',
                          value: controllerMaps.jmlLokasiUmkm.toString(),
                          icon: Icons.location_on,
                          iconColor: Colors.orange,
                          bgColor: Colors.orange.withOpacity(0.1),
                          onTap: () {
                            Get.toNamed('/maps');
                          },
                        )),
                        Obx(() => _buildStatisticCard(
                          title: 'Pemilik UMKM',
                          value: controllerMaps.jmlUserUmkm.toString(),
                          icon: Icons.people,
                          iconColor: Colors.blue,
                          bgColor: Colors.blue.withOpacity(0.1),
                          onTap: () {
                            Get.toNamed('/umkm');
                          },
                        )),
                        _buildStatisticCard(
                          title: 'Meeting Aktif',
                          value: '0',
                          icon: Icons.event,
                          iconColor: Colors.green,
                          bgColor: Colors.green.withOpacity(0.1),
                          onTap: () {
                            Get.to(() => MeetingView());
                          },
                        ),
                        _buildStatisticCard(
                          title: 'Investor',
                          value: '0',
                          icon: Icons.account_balance,
                          iconColor: Colors.purple,
                          bgColor: Colors.purple.withOpacity(0.1),
                          onTap: () {
                            Get.snackbar(
                              'Info', 
                              'Fitur investor akan segera hadir',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Recent Activity Section
                    Text(
                      'Aktivitas Terbaru',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Recent Activities List
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 3, // Contoh data
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          color: Colors.grey[300],
                        ),
                        itemBuilder: (context, index) {
                          List<Map<String, dynamic>> activities = [
                            {
                              'title': 'Meeting Baru Ditambahkan',
                              'subtitle': 'Meeting dengan investor telah dijadwalkan',
                              'time': '2 jam yang lalu',
                              'icon': Icons.event_note,
                              'color': Colors.blue,
                            },
                            {
                              'title': 'Lokasi UMKM Baru',
                              'subtitle': 'UMKM baru telah didaftarkan di sistem',
                              'time': '1 hari yang lalu',
                              'icon': Icons.location_on,
                              'color': Colors.orange,
                            },
                            {
                              'title': 'Pengumuman Sistem',
                              'subtitle': 'Update aplikasi tersedia versi 2.1.0',
                              'time': '3 hari yang lalu',
                              'icon': Icons.system_update,
                              'color': Colors.green,
                            },
                          ];
                          
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            leading: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: activities[index]['color'].withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                activities[index]['icon'],
                                color: activities[index]['color'],
                              ),
                            ),
                            title: Text(
                              activities[index]['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(activities[index]['subtitle']),
                                const SizedBox(height: 4),
                                Text(
                                  activities[index]['time'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios, size: 16),
                              onPressed: () {
                                // Action for viewing activity detail
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Upcoming Meetings Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Meeting Mendatang',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: secondaryColor,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => MeetingView());
                          },
                          child: Text(
                            'Lihat Semua',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Placeholder for upcoming meetings
                    Obx(() {
                      if (controllerMeet.isLoading.value) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          ),
                        );
                      }
                      
                      if (controllerMeet.meetingList.isEmpty) {
                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.event_busy,
                                  size: 48,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Tidak ada meeting mendatang',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.add),
                                  label: const Text('Jadwalkan Meeting'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.to(() => MeetingView());
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      
                      // Show first two meetings if available
                      final upcomingMeetings = controllerMeet.meetingList.length > 2 
                          ? controllerMeet.meetingList.sublist(0, 2) 
                          : controllerMeet.meetingList;
                          
                      return Column(
                        children: upcomingMeetings.map((meeting) {
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Date indicator
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: secondaryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${meeting['tanggal']?.substring(0, 2) ?? 'XX'}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: secondaryColor,
                                          ),
                                        ),
                                        Text(
                                          '${_getMonthAbbr(meeting['tanggal'])}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: secondaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  const SizedBox(width: 16),
                                  
                                  // Meeting details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          meeting['judul'] ?? 'Tak Berjudul',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: secondaryColor,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.store,
                                              size: 16,
                                              color: Colors.grey[600],
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                meeting['umkm']?['name'] ?? 'Loading...',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 16,
                                              color: Colors.grey[600],
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                meeting['lokasi_meeting'] ?? '-',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  // Status indicator
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8, 
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.orange,
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      'MENUNGGU',
                                      style: GoogleFonts.openSans(
                                        textStyle: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }),
                    
                    const SizedBox(height: 40),
                    
                    // Footer
                    Text(
                      "© Pusat Usaha Bersama dan Kemitraan ${DateTime.now().year}. All rights reserved.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: primaryColor,
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     Get.bottomSheet(
      //       Container(
      //         padding: const EdgeInsets.all(20),
      //         decoration: const BoxDecoration(
      //           color: Colors.white,
      //           borderRadius: BorderRadius.only(
      //             topLeft: Radius.circular(20),
      //             topRight: Radius.circular(20),
      //           ),
      //         ),
      //         child: Column(
      //           mainAxisSize: MainAxisSize.min,
      //           children: [
      //             Text(
      //               'Tambah Baru',
      //               style: GoogleFonts.openSans(
      //                 textStyle: TextStyle(
      //                   fontSize: 18,
      //                   fontWeight: FontWeight.bold,
      //                   color: secondaryColor,
      //                 ),
      //               ),
      //             ),
      //             const SizedBox(height: 20),
      //             _buildActionButton(
      //               icon: Icons.event,
      //               label: 'Jadwalkan Meeting',
      //               color: Colors.blue,
      //               onTap: () {
      //                 Get.back();
      //                 Get.to(() => MeetingView());
      //               },
      //             ),
      //             const SizedBox(height: 10),
      //             _buildActionButton(
      //               icon: Icons.store,
      //               label: 'Tambah UMKM',
      //               color: Colors.orange,
      //               onTap: () {
      //                 Get.back();
      //                 Get.toNamed('/umkm');
      //               },
      //             ),
      //             const SizedBox(height: 10),
      //             _buildActionButton(
      //               icon: Icons.assessment,
      //               label: 'Buat Laporan',
      //               color: Colors.green,
      //               onTap: () {
      //                 Get.back();
      //                 Get.snackbar(
      //                   'Info', 
      //                   'Fitur laporan akan segera hadir',
      //                   snackPosition: SnackPosition.BOTTOM,
      //                 );
      //               },
      //             ),
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
  
  Widget _buildQuickActionButton({
    required IconData icon, 
    required String label, 
    required VoidCallback onTap
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatisticCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: color.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  String _getMonthAbbr(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return 'XXX';
    
    try {
      // Assuming dateStr format is "DD-MM-YYYY"
      final List<String> parts = dateStr.split("-");
      if (parts.length < 2) return 'XXX';
      
      final int month = int.tryParse(parts[1]) ?? 1;
      final List<String> months = ['JAN', 'FEB', 'MAR', 'APR', 'MEI', 'JUN', 'JUL', 'AGU', 'SEP', 'OKT', 'NOV', 'DES'];
      return months[month - 1];
    } catch (e) {
      return 'XXX';
    }
  }
}