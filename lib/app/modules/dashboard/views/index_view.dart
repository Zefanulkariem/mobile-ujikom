import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pubk_mobile2/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:pubk_mobile2/app/modules/maps/controllers/maps_controller.dart';
import 'package:pubk_mobile2/app/modules/meeting/controllers/meeting_controller.dart';
import 'package:shimmer/shimmer.dart';

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
      body: RefreshIndicator(
        color: primaryColor,
        onRefresh: () async {
          await controllerMeet.getMeetings();
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 170.0,
              floating: false,
              pinned: true,
              elevation: 0,
              backgroundColor: primaryColor,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                title: Text(
                  'PUBK Mobile',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Background Pattern
                    Opacity(
                      opacity: 0.15,
                      child: Image.network(
                        'https://img.freepik.com/free-vector/abstract-pattern-design_1053-515.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SELAMAT DATANG',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
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
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                child: Card(
                  elevation: 8,
                  shadowColor: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildQuickActionButton(
                          icon: Icons.map_rounded,
                          label: 'Peta UMKM',
                          color: Colors.orange,
                          onTap: () {
                            final dashboardController = Get.find<DashboardController>();
                            dashboardController.changeIndex(1);
                          },
                        ),
                        _buildQuickActionButton(
                          icon: Icons.people_alt_rounded,
                          label: 'Meeting',
                          color: Colors.blue,
                          onTap: () {
                            final dashboardController = Get.find<DashboardController>();
                            dashboardController.changeIndex(2);
                          },
                        ),
                        // _buildQuickActionButton(
                        //   icon: Icons.storefront_rounded,
                        //   label: 'UMKM',
                        //   color: primaryColor,
                        //   onTap: () {
                        //     Get.toNamed('/umkm');
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            
            // Statistics
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.bar_chart_rounded,
                          color: secondaryColor,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Statistik PUBK',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() => _buildStatisticCard(
                                title: 'Jumlah UMKM',
                                value: controllerMaps.jmlLokasiUmkm.toString(),
                                icon: Icons.location_on_rounded,
                                iconColor: Colors.white,
                                bgColor: HexColor('#FF7E36'),
                                onTap: () {
                                  Get.toNamed('/maps');
                                },
                              )),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Obx(() => _buildStatisticCard(
                                title: 'Pemilik UMKM',
                                value: controllerMaps.jmlUserUmkm.toString(),
                                icon: Icons.people_alt_rounded,
                                iconColor: Colors.white,
                                bgColor: HexColor('#3B82F6'),
                                onTap: () {
                                  Get.toNamed('/umkm');
                                },
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Meetings
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.event_rounded,
                              color: secondaryColor,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Meeting Mendatang',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: secondaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextButton.icon(
                          onPressed: () {
                            final dashboardController = Get.find<DashboardController>();
                            dashboardController.changeIndex(2);
                          },
                          icon: Icon(
                            Icons.arrow_forward_rounded,
                            color: primaryColor,
                            size: 18,
                          ),
                          label: Text(
                            'Lihat Semua',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Meeting List
                    Obx(() {
                      if (controllerMeet.isLoading.value) {
                        return _buildMeetingLoadingSkeleton();
                      }

                      if (controllerMeet.meetingList.isEmpty) {
                        return _buildEmptyMeetingCard(primaryColor);
                      }

                      final upcomingMeetings =
                          controllerMeet.meetingList.length > 2
                              ? controllerMeet.meetingList.sublist(0, 2)
                              : controllerMeet.meetingList;

                      return Column(
                        children: upcomingMeetings.map((meeting) {
                          return _buildMeetingCard(meeting, secondaryColor);
                        }).toList(),
                      );
                    }),
                  ],
                ),
              ),
            ),

            // Footer
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                child: Column(
                  children: [
                    Divider(color: Colors.grey[300]),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.eco_rounded,
                          color: primaryColor,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "PUBK",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Pusat Usaha Bersama dan Kemitraan",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "© ${DateTime.now().year} All rights reserved",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.3), width: 1.5),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
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
      elevation: 4,
      shadowColor: Colors.black12,
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
              Row(
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
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                value,
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMeetingCard(Map<String, dynamic> meeting, Color secondaryColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date container
            Container(
              width: 50,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    HexColor('#3B82F6'),
                    HexColor('#1D4ED8'),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: HexColor('#3B82F6').withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    '${meeting['tanggal']?.substring(0, 2) ?? 'XX'}',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    '${_getMonthAbbr(meeting['tanggal'])}',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meeting['judul'] ?? 'Tak Berjudul',
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
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.store_rounded,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          meeting['umkm']?['name'] ?? 'Loading...',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[800],
                            ),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          meeting['lokasi_meeting'] ?? '-',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[800],
                            ),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        meeting['jam'] ?? '00:00',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.orange,
                  width: 1.5,
                ),
              ),
              child: Text(
                'MENUNGGU',
                style: GoogleFonts.montserrat(
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
  }

  Widget _buildEmptyMeetingCard(Color primaryColor) {
    return Card(
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.event_busy_rounded,
                size: 48,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Belum Ada Meeting',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Jadwalkan meeting untuk UMKM',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.add_rounded),
              label: const Text('Buat Meeting'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                elevation: 2,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                final dashboardController = Get.find<DashboardController>();
                dashboardController.changeIndex(2);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeetingLoadingSkeleton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(
          2,
          (index) => Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              height: 120,
              width: double.infinity,
            ),
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
      final List<String> months = [
        'JAN',
        'FEB',
        'MAR',
        'APR',
        'MEI',
        'JUN',
        'JUL',
        'AGU',
        'SEP',
        'OKT',
        'NOV',
        'DES'
      ];
      return months[month - 1];
    } catch (e) {
      return 'XXX';
    }
  }
}