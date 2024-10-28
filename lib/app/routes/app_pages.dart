import 'package:get/get.dart';
import 'package:serkom/app/modules/data_pemilih/bindings/data_pemilih_binding.dart';
import 'package:serkom/app/modules/data_pemilih/view/data_pemilih_view.dart';
import 'package:serkom/app/modules/detail_pemilih/bindings/detail_pemilih_binding.dart';
import 'package:serkom/app/modules/detail_pemilih/view/detail_pemilih_view.dart';
import 'package:serkom/app/modules/form_entry/bindings/form_entry_binding.dart';
import 'package:serkom/app/modules/form_entry/view/form_entry_view.dart';
import 'package:serkom/app/modules/home_screen/bindings/home_binding.dart';
import 'package:serkom/app/modules/home_screen/view/home_view.dart';
import 'package:serkom/app/modules/informasi/bindings/informasi_binding.dart';
import 'package:serkom/app/modules/informasi/view/data_pemilih_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.FORMENTRY,
      page: () => FormEntryView(),
      binding: FormEntryBinding(),
    ),
    GetPage(
      name: _Paths.DATAPEMILIH,
      page: () => DataPemilihView(),
      binding: DataPemilihBinding(),
    ),
    GetPage(
      name: _Paths.INFORMASI,
      page: () => InformasiView(),
      binding: InformfasiBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => DetailPemilihView(
        id: Get.arguments,
      ), // Update this if necessary
      binding: DetailPemilihBinding(),
    ),
  ];
}
