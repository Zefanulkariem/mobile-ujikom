import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndexView extends GetView {
  const IndexView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Beranda'),
              onTap: () {
                // Tambahkan logika navigasi di sini
                Get.back(); // Tutup drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Pengaturan'),
              onTap: () {
                // Tambahkan logika navigasi di sini
                Get.back(); // Tutup drawer
              },
            ),
            // Tambahkan item menu lainnya di sini
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Selamat Datang!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: <Widget>[
                _buildDashboardCard(
                  title: 'Total Pengguna',
                  icon: Icons.people,
                  value: '100',
                  onTap: () {
                    // Tambahkan aksi ketika card ditekan
                    print('Total Pengguna Ditekan');
                  },
                ),
                _buildDashboardCard(
                  title: 'Produk Terjual',
                  icon: Icons.shopping_cart,
                  value: '500',
                  onTap: () {
                    // Tambahkan aksi ketika card ditekan
                    print('Produk Terjual Ditekan');
                  },
                ),
                _buildDashboardCard(
                  title: 'Pendapatan',
                  icon: Icons.monetization_on,
                  value: 'Rp 1.000.000',
                  onTap: () {
                    // Tambahkan aksi ketika card ditekan
                    print('Pendapatan Ditekan');
                  },
                ),
                // Tambahkan card-card lain sesuai kebutuhan
              ],
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Grafik Penjualan',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    // Di sini Anda bisa menambahkan widget untuk menampilkan grafik
                    // Contoh: Placeholder untuk grafik
                    Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: Center(
                        child: Text('Grafik akan ditampilkan di sini'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Footer Dashboard',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
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
              Icon(icon, size: 40, color: Colors.blue),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}