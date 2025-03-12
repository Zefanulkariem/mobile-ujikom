import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import '../../../utils/api.dart';

class OperasionalView extends StatefulWidget {
  @override
  _OperasionalViewState createState() => _OperasionalViewState();
}

class _OperasionalViewState extends State<OperasionalView> {
  List<dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOperasionalData();
  }

  Future<void> fetchOperasionalData() async {
    try {
      final response = await http.get(Uri.parse(BaseUrl.operasional));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          userData = data['data'];
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Get.snackbar("Error", "Gagal mengambil data operasional");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Operasional UMKM")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userData == null || userData!.isEmpty
              ? Center(child: Text("Tidak ada data"))
              : ListView.builder(
                  itemCount: userData!.length,
                  itemBuilder: (context, index) {
                    final item = userData![index];

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
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
                                "ID UMKM: ${item['id_umkm']}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text("Jumlah Karyawan: ${item['jml_karyawan']}",
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(height: 10),
                              item['user'] != null
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Nama Pemilik: ${item['user']['name']}",
                                            style: TextStyle(fontSize: 16)),
                                        Text("Email: ${item['user']['email']}",
                                            style: TextStyle(fontSize: 16)),
                                        Text("No Telp: ${item['user']['no_telp']}",
                                            style: TextStyle(fontSize: 16)),
                                        Text("Alamat: ${item['user']['alamat']}",
                                            style: TextStyle(fontSize: 16)),
                                      ],
                                    )
                                  : Text("Data pengguna tidak tersedia"),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
