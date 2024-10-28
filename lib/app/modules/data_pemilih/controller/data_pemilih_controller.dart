import 'package:get/get.dart';
import 'package:serkom/app/db/database_helper.dart';

class DataPemilihController extends GetxController {
  var pemilihList =
      <Map<String, dynamic>>[].obs; // List hanya untuk menyimpan nama pemilih

  @override
  void onInit() {
    super.onInit();
    fetchPemilihData(); // Memanggil fungsi saat controller diinisialisasi
  }

  @override
  void onReady() {
    super.onReady();
    fetchPemilihData();
  }

  void fetchPemilihData() async {
    var entries =
        await DatabaseHelper().getAllEntries(); // Mengambil data dari SQLite
    pemilihList.assignAll(entries.map((entry) => {
          'id': entry['id'], // Ambil ID
          'nama': entry['nama'] as String
        }));
  }
}
