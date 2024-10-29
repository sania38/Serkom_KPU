import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:serkom/app/constant/font_constant.dart';
import 'package:serkom/app/modules/detail_pemilih/controller/detail_pemilih_controller.dart';
import 'dart:io';

class DetailPemilihView extends GetView<DetailPemilihController> {
  final int id;

  // Constructor that accepts the id parameter
  DetailPemilihView({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Pemilih",
          style: FontConstant.heading2,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        var pemilih = controller.pemilihDetail;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'NIK',
                      style: FontConstant.bodyStyle3,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      ":  ${pemilih['nik'] ?? 'Tidak tersedia'}",
                      style: FontConstant.bodyStyle,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'NAMA',
                      style: FontConstant.bodyStyle3,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      ":  ${pemilih['nama'] ?? 'Tidak tersedia'}",
                      style: FontConstant.bodyStyle,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'NO HP',
                      style: FontConstant.bodyStyle3,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      ":  ${pemilih['no_hp'] ?? 'Tidak tersedia'}",
                      style: FontConstant.bodyStyle,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'JK',
                      style: FontConstant.bodyStyle3,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      ":  ${pemilih['jk'] == '1' ? 'Laki-laki' : pemilih['jk'] == '2' ? 'Perempuan' : 'Tidak tersedia'}",
                      style: FontConstant.bodyStyle,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'TANGGAL',
                      style: FontConstant.bodyStyle3,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      ":  ${pemilih['tanggal'] ?? 'Tidak tersedia'}",
                      style: FontConstant.bodyStyle,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Alamat',
                      style: FontConstant.bodyStyle3,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      ":  ${pemilih['address'] ?? 'Tidak tersedia'}",
                      style: FontConstant.bodyStyle,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Center(child: Text("Gambar", style: FontConstant.heading2)),
              pemilih['image_path'] != null && pemilih['image_path'].isNotEmpty
                  ? Column(
                      children: [
                        SizedBox(height: 8),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.3,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromARGB(255, 0, 156, 196),
                                width: 5,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                            child: Image.file(
                              File(pemilih['image_path']),
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    )
                  : Text(
                      'Image Path: Tidak tersedia',
                      style: TextStyle(fontSize: 18),
                    ),
            ],
          ),
        );
      }),
    );
  }
}
