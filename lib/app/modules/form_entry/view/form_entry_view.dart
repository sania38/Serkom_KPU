import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:serkom/app/constant/font_constant.dart';
import 'package:serkom/app/db/database_helper.dart';
import 'package:serkom/app/modules/detail_pemilih/controller/detail_pemilih_controller.dart';
import 'package:serkom/app/modules/detail_pemilih/view/detail_pemilih_view.dart';

import '../controller/form_entry_controller.dart';

class FormEntryView extends GetView<FormEntryController> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Form Entry",
          style: FontConstant.heading2,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
          child: Column(
            children: [
              ListView.builder(
                itemCount: controller.teks.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                clipBehavior: Clip.none,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                controller.teks[index],
                                style: FontConstant.bodyStyle2,
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: controller.control[index],
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.all(12),
                                      hintText: controller.hint[index],
                                    ),
                                  ),
                                  Obx(() {
                                    return Text(
                                      controller.errorMessages[index],
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "JK",
                      style: FontConstant.bodyStyle2,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        Obx(() => Radio<int>(
                              value: 1,
                              groupValue: controller.selectedValue.value,
                              onChanged: (value) {
                                controller.selectedValue.value = value!;
                              },
                            )),
                        Text("L", style: FontConstant.bodyStyle2),
                        Obx(() => Radio<int>(
                              value: 2,
                              groupValue: controller.selectedValue.value,
                              onChanged: (value) {
                                controller.selectedValue.value = value!;
                              },
                            )),
                        Text("P", style: FontConstant.bodyStyle2),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Tanggal",
                      style: FontConstant.bodyStyle2,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: controller.tanggal,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(12),
                            hintText: "Pilih Tanggal",
                          ),
                          onTap: () => controller.selectDate(context),
                        ),
                        Obx(() {
                          return Text(
                            controller.errtangal.value,
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Alamat",
                      style: FontConstant.bodyStyle2,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                maxLines: 4,
                                controller: TextEditingController(
                                    text: controller.address.value),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.all(12),
                                  hintText: "klik ambil alamat",
                                ),
                                onChanged: (value) {
                                  // Update controller jika teks diubah
                                  controller.address.value = value;
                                },
                              ),
                              Text(
                                controller.errAlamat.value,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ],
                          );
                        }),
                        ElevatedButton(
                          onPressed: () async {
                            await controller.getCurrentLocation();
                          },
                          child: Text(
                            "Ambil Lokasi",
                            style: FontConstant.textStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Gambar",
                      style: FontConstant.bodyStyle2,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null && result.files.isNotEmpty) {
                          controller.setImage(result.files.single.path!);
                        }
                      },
                      child: Obx(() {
                        return Column(
                          children: [
                            Container(
                              height: 120,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  controller.imagePath.value.isNotEmpty
                                      ? Expanded(
                                          child: Image.file(
                                            File(controller.imagePath.value),
                                            width: double.infinity,
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            Image.asset(
                                              "assets/icons/upload.png",
                                              width: 40,
                                              height: 40.0,
                                              fit: BoxFit.fill,
                                            ),
                                            Text("Tambahkan Gambar",
                                                style: FontConstant.textStyle),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                            Text(
                              controller.errImagePath.value,
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 48,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                ),
                onPressed: () async {
                  // Ambil NIK dari input
                  String nik = controller.control[0].text;

                  // Cek apakah NIK sudah ada di dalam database
                  bool nikExists = await _dbHelper.checkIfNikExists(nik);

                  if (nikExists) {
                    Get.snackbar(
                      'Informasi',
                      'NIK sudah ada di database.',
                      snackPosition: SnackPosition.TOP,
                    );

                    // Ambil ID pemilih dari database
                    int? id = await _dbHelper.getIdByNik(nik);
                    print(nik);

                    if (id != null) {
                      final detailController =
                          Get.find<DetailPemilihController>();
                      detailController.fetchPemilihDetail(id);
                      Get.to(DetailPemilihView(id: id));
                    } else {
                      Get.snackbar(
                          'Not Found', 'NIK tidak ditemukan di database');
                    }
                  } else {
                    // Validasi input sebelum menyimpan data jika NIK tidak ada
                    if (controller.validateInput()) {
                      try {
                        await controller
                            .saveData(); // Simpan data ke SharedPreferences
                        await controller
                            .saveDataToSQLite(); // Simpan data ke SQLite
                        await controller
                            .clearData(); // Hapus data dari SharedPreferences

                        for (var ctrl in controller.control) {
                          ctrl.clear();
                        }
                        controller.tanggal.clear();
                        controller.lokasi.clear();
                        controller.imagePath.value = '';

                        print("Data submitted, saved to SQLite, and cleared.");
                      } catch (e) {
                        print("Error occurred: $e");
                        Get.snackbar(
                          'Error',
                          'Terjadi kesalahan saat menyimpan data.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    } else {
                      Get.snackbar(
                          'Invalid Input', 'Silakan periksa input Anda.');
                    }
                  }
                },
                child: Text("Kirim", style: FontConstant.textStyle),
              )
            ],
          ),
        ),
      ),
    );
  }
}
