import 'package:get/get.dart';
import 'package:serkom/app/db/database_helper.dart';

class DetailPemilihController extends GetxController {
  var pemilihDetail = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();

    // Retrieve ID from arguments and ensure it's an integer
    final dynamic idArg = Get.arguments;
    final int id =
        (idArg is int) ? idArg : int.tryParse(idArg.toString()) ?? -1;

    if (id != -1) {
      fetchPemilihDetail(id);
    } else {
      print("Invalid ID: $id");
      pemilihDetail.value = {'error': 'Invalid ID provided'};
    }
    fetchPemilihDetail(id);
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
