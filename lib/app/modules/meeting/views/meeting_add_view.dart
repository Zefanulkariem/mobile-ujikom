import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pubk_mobile2/app/modules/meeting/controllers/meeting_controller.dart';
import 'package:intl/intl.dart';

class MeetingAddView extends GetView<MeetingController> {
  MeetingAddView({super.key});
  
  final TextEditingController judulController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController investorIdController = TextEditingController();
  final TextEditingController umkmIdController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    
    final primaryColor = HexColor('#6750A4');
    // final secondaryColor = HexColor('#344767');
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(
          "Tambah Meeting",
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() => Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                
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
                        "Buat Meeting Baru",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Lengkapi formulir berikut untuk membuat jadwal meeting baru",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: _formKey,
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
                              "Informasi Meeting",
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(height: 20),
                            
                            _buildTextFormField(
                              controller: judulController,
                              labelText: "Judul Meeting",
                              hintText: "Masukkan judul meeting",
                              icon: Icons.title,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Judul meeting tidak boleh kosong';
                                }
                                return null;
                              },
                              primaryColor: primaryColor,
                            ),
                            
                            const SizedBox(height: 16),
                            
                            _buildTextFormField(
                              controller: lokasiController,
                              labelText: "Lokasi Meeting",
                              hintText: "Masukkan lokasi meeting",
                              icon: Icons.location_on,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Lokasi meeting tidak boleh kosong';
                                }
                                return null;
                              },
                              primaryColor: primaryColor,
                            ),
                            
                            const SizedBox(height: 16),
                            
                            _buildDateField(
                              context: context,
                              controller: tanggalController,
                              labelText: "Tanggal Meeting",
                              hintText: "Pilih tanggal meeting",
                              icon: Icons.calendar_today,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tanggal meeting tidak boleh kosong';
                                }
                                return null;
                              },
                              primaryColor: primaryColor,
                            ),
                            
                            const SizedBox(height: 24),
                            
                            Text(
                              "Informasi Peserta",
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(height: 16),
                            
                            // _buildTextFormField(
                            //   controller: investorIdController,
                            //   labelText: "ID Investor",
                            //   hintText: "Masukkan ID investor",
                            //   icon: Icons.business,
                            //   isNumber: true,
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return 'ID investor tidak boleh kosong';
                            //     }
                            //     if (int.tryParse(value) == null) {
                            //       return 'ID harus berupa angka';
                            //     }
                            //     return null;
                            //   },
                            //   primaryColor: primaryColor,
                            // ),
                            
                            const SizedBox(height: 16),
                            
                            _buildTextFormField(
                              controller: umkmIdController,
                              labelText: "ID UMKM",
                              hintText: "Masukkan ID UMKM",
                              icon: Icons.store,
                              isNumber: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'ID UMKM tidak boleh kosong';
                                }
                                if (int.tryParse(value) == null) {
                                  return 'ID harus berupa angka';
                                }
                                return null;
                              },
                              primaryColor: primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      _submitForm();
                      Get.snackbar("Sukses", "Meeting berhasil ditambahkan");
                    },
                    child: Text(
                      "Simpan Meeting",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
              ],
            ),
          ),
          
          
          if (controller.isLoading.value)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      )),
    );
  }
  

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
    required String? Function(String?) validator,
    required Color primaryColor,
    bool isNumber = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(icon, color: primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
    );
  }
  

  Widget _buildDateField({
    required BuildContext context,
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
    required String? Function(String?) validator,
    required Color primaryColor,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(icon, color: primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: primaryColor,
                ),
              ),
              child: child!,
            );
          },
        );
        
        if (pickedDate != null) {
          // Format tanggal ke string
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          controller.text = formattedDate;
        }
      },
    );
  }
  
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      var authToken = GetStorage();
      int idInvestor = authToken.read('id_investor') ?? 0;
      
      controller.addMeeting(
        idInvestor: idInvestor,
        idUmkm: int.parse(umkmIdController.text),
        judul: judulController.text,
        lokasiMeeting: lokasiController.text,
        tanggal: tanggalController.text,
      ).then((_) {

        if (!controller.isLoading.value) {
          Get.back();
        }
      });
    }
  }
}