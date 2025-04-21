import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pubk_mobile2/app/modules/profile/controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2E7A35);
    final backgroundColor = Colors.grey[100];
    
    return Scaffold(
      backgroundColor: backgroundColor,
      body: RefreshIndicator(
        color: primaryColor,
        onRefresh: controller.getProfile,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final profileData = controller.profile.value;
          
          if (profileData == null) {
            return const Center(child: Text('Tidak ada data profil'));
          }
          
          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // App Bar dengan Avatar
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                backgroundColor: primaryColor,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          primaryColor,
                          primaryColor.withOpacity(0.8),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        Hero(
                          tag: 'profileAvatar',
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              color: Colors.white,
                            ),
                            child: const ClipOval(
                              child: Icon(Icons.person, size: 50, color: primaryColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          profileData.name ?? 'Nama Pengguna',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  collapseMode: CollapseMode.parallax,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white),
                    onPressed: () {
                      Get.dialog(
                        AlertDialog(
                          title: Text(
                            'Logout',
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                          ),
                          content: Text(
                            'Apakah Anda yakin ingin keluar?',
                            style: GoogleFonts.montserrat(),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: Text(
                                'Batal',
                                style: GoogleFonts.montserrat(color: Colors.grey),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.logout();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Logout',
                                style: GoogleFonts.montserrat(),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildInfoCard(
                        icon: Icons.email_outlined,
                        title: 'Email',
                        value: profileData.email ?? 'email@example.com',
                        iconColor: Colors.blue,
                      ),
                    
                      const SizedBox(height: 16),
                      
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person_outline, 
                                    color: primaryColor,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Informasi Pribadi',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(height: 24),
                              _buildDetailItem(
                                icon: Icons.phone_outlined, 
                                label: 'Nomor Telepon', 
                                value: profileData.noTelp ?? '-',
                                iconColor: Colors.green,
                              ),
                              const SizedBox(height: 12),
                              _buildDetailItem(
                                icon: Icons.location_on_outlined, 
                                label: 'Alamat', 
                                value: profileData.alamat ?? '-',
                                iconColor: Colors.red,
                              ),
                              const SizedBox(height: 12),
                              _buildDetailItem(
                                icon: Icons.calendar_today_outlined, 
                                label: 'Bergabung Sejak', 
                                value: _formatDate(profileData.createdAt), //format tgl
                                iconColor: Colors.amber,
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: _buildActionButton(
                      //         label: 'Edit Profil',
                      //         icon: Icons.edit_outlined,
                      //         color: primaryColor,
                      //         onTap: () {
                      //           // Navigate to edit profile
                      //           Get.toNamed('/edit-profile');
                      //         },
                      //       ),
                      //     ),
                      //     const SizedBox(width: 12),
                      //     Expanded(
                      //       child: _buildActionButton(
                      //         label: 'Ubah Password',
                      //         icon: Icons.lock_outline,
                      //         color: Colors.orange,
                      //         onTap: () {
                      //           // Navigate to change password
                      //           Get.toNamed('/change-password');
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      
                      // const SizedBox(height: 16),
                      
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: _buildStatCard(
                      //         label: 'Meeting',
                      //         value: '5',
                      //         icon: Icons.event_note_outlined,
                      //         iconColor: Colors.blue,
                      //         backgroundColor: Colors.blue.withOpacity(0.1),
                      //       ),
                      //     ),
                      //     const SizedBox(width: 12),
                      //     Expanded(
                      //       child: _buildStatCard(
                      //         label: 'UMKM',
                      //         value: '2',
                      //         icon: Icons.store_outlined,
                      //         iconColor: Colors.purple,
                      //         backgroundColor: Colors.purple.withOpacity(0.1),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      
                      const SizedBox(height: 30),
                      
                      Text(
                        'PUBK Mobile v.1.0.0',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
  
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withOpacity(0.3)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.montserrat(
                  color: color,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildStatCard({
    required String label,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 3),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
  
  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '-';
    
    try {
      final date = DateTime.parse(dateStr);
      final months = [
        'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
        'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (e) {
      return dateStr;
    }
  }
}