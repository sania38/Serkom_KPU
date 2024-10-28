import 'package:get/get.dart';

import '../controller/detail_pemilih_controller.dart';

class DetailPemilihBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPemilihController>(
      () => DetailPemilihController(),
    );
  }
}
