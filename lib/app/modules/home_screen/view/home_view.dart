import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:serkom/app/constant/font_constant.dart';
import 'package:serkom/app/modules/data_pemilih/controller/data_pemilih_controller.dart';
import 'package:serkom/app/modules/data_pemilih/view/data_pemilih_view.dart';
import 'package:serkom/app/modules/informasi/view/data_pemilih_view.dart';

import '../../form_entry/view/form_entry_view.dart';
import '../controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final controllerData = Get.put(DataPemilihController());
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  'KPU',
                  style: FontConstant.headingStyle,
                ),
                SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.icon.length,
                    physics: const ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Card(
                          child: SizedBox(
                            height: 56.0,
                            child: ListTile(
                              leading: Image.asset(
                                controller.icon[index],
                                width: 32.0,
                                height: 32.0,
                                fit: BoxFit.fill,
                              ),
                              title: Text(
                                controller.menu[index],
                                style: FontConstant.bodyStyle,
                              ),
                              onTap: () {
                                if (index == 0) {
                                  Get.to(() => InformasiView());
                                } else if (index == 1) {
                                  Get.to(() => FormEntryView());
                                } else if (index == 2) {
                                  controllerData.fetchPemilihData();
                                  Get.to(() => DataPemilihView());
                                } else if (index == 3) {
                                  SystemNavigator.pop();
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
