import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serkom/app/constant/font_constant.dart';

import '../controller/data_pemilih_controller.dart';

class InformasiView extends GetView<InformasiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Informasi",
          style: FontConstant.heading2,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat Datang di Halaman Informasi Pemilihan Umum!',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Pemilihan umum adalah kesempatan bagi setiap warga negara untuk berpartisipasi aktif dalam menentukan arah masa depan bangsa. Suara Anda sangat berharga! Pemilihan umum ini memungkinkan setiap suara untuk didengar dan menentukan kepemimpinan serta kebijakan yang akan membawa perubahan bagi negara.",
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Mengapa pemilihan umum penting?',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Pemilihan umum adalah tulang punggung demokrasi. Melalui pemilihan, kita sebagai masyarakat memiliki kesempatan untuk memilih pemimpin yang terbaik, yang dapat mewakili aspirasi, kebutuhan, dan harapan kita. Partisipasi Anda dalam pemilihan ini:",
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  controller.penting.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 1}.', // Numbering
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            controller.penting[index],
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Siapa yang Berhak Memilih?',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Anda berhak memilih dalam pemilihan umum ini jika:",
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  controller.hak.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 1}.', // Numbering
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            controller.hak[index],
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Kembali',
                  style: FontConstant.bodyStyle3,
                ),
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                  Size(double.infinity, 40),
                )),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
