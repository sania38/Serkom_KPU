import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/data_pemilih_controller.dart';

class InformasiView extends GetView<InformasiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          'InformasiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
