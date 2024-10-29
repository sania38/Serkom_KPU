import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serkom/app/constant/font_constant.dart';
import 'package:serkom/app/modules/form_entry/controller/form_entry_controller.dart';
import '../controller/data_pemilih_controller.dart';

class DataPemilihView extends GetView<DataPemilihController> {
  @override
  Widget build(BuildContext context) {
    final del = Get.put(FormEntryController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Data Pemilih",
          style: FontConstant.heading2,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.pemilihList.length,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            var pemilih = controller.pemilihList[index];

            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Card(
                child: SizedBox(
                  height: 56.0,
                  child: ListTile(
                    title: Text(
                      pemilih['nama'],
                      style: FontConstant.bodyStyle,
                    ),
                    onTap: () {
                      if (pemilih['id'] != null) {
                        Get.toNamed('/detail', arguments: pemilih['id']);
                      } else {
                        print("ID is null for pemilih: $pemilih");
                      }
                    },
                  ),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete),
        onPressed: () {
          del.clearSQLiteData();
          Get.back();
        },
      ),
    );
  }
}
