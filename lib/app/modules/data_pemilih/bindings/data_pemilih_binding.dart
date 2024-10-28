import 'package:get/get.dart';

import '../controller/data_pemilih_controller.dart';

class DataPemilihBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataPemilihController>(
      () => DataPemilihController(),
    );
  }
}
