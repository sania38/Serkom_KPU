import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:serkom/app/modules/data_pemilih/controller/data_pemilih_controller.dart';
import 'package:serkom/app/modules/form_entry/controller/form_entry_controller.dart';
import 'package:serkom/app/modules/informasi/controller/data_pemilih_controller.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(FormEntryController());
  Get.put(DataPemilihController());
  Get.put(InformasiController());
  runApp(
    ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) {
        return MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Serkom',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 156, 196)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
