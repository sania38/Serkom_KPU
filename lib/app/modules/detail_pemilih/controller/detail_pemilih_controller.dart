import 'package:get/get.dart';
import 'package:serkom/app/db/database_helper.dart';

class DetailPemilihController extends GetxController {
  var pemilihDetail = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void fetchPemilihDetail(int id) async {
    var entries = await DatabaseHelper().getAllEntries();
    try {
      // Search for the entry by ID
      pemilihDetail.value = entries.firstWhere((entry) => entry['id'] == id);
    } catch (e) {
      // Handle the case where the entry is not found
      print("Entry not found for ID $id");
      pemilihDetail.value = {'error': 'Entry not found'};
    }
  }
}
