import 'package:get/get.dart';

import '../controller/data_pemilih_controller.dart';

class InformfasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InformasiController>(
      () => InformasiController(),
    );
  }
}
