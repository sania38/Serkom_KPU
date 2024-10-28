import 'package:get/get.dart';
import 'package:serkom/app/db/database_helper.dart';

class DataPemilihController extends GetxController {
  var pemilihList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPemilihData();
  }

  @override
  void onReady() {
    super.onReady();
    fetchPemilihData();
  }

  //mengambil data dari sqlite
  void fetchPemilihData() async {
    var entries = await DatabaseHelper().getAllEntries();
    pemilihList.assignAll(entries.map((entry) => {
          'id': entry['id'], // Ambil ID
          'nama': entry['nama'] as String
        }));
  }
}
