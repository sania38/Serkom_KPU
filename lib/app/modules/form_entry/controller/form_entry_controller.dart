import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:serkom/app/db/database_helper.dart';
// import 'package:location/location.dart' as loc;
import 'package:shared_preferences/shared_preferences.dart';

class FormEntryController extends GetxController {
  var teks = <String>["NIK", "Nama", "No.HP"]; // Contoh teks
  var hint = <String>[
    "3305xxxxxxxxxxxx",
    "Nama",
    "08xxxxxxxxxxx"
  ]; // Contoh teks
  var control = <TextEditingController>[].obs;
  var selectedValue = 2.obs;
  var tanggal = TextEditingController();
  var lokasi = TextEditingController();
  var imagePath = ''.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var address = ''.obs;
  var isLoading = false.obs;
  var errorMessages =
      <String>["", "", ""].obs; // Menyimpan pesan error untuk setiap field
  var errtangal = ''.obs;
  var errAlamat = ''.obs;
  var errImagePath = ''.obs;

  DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      // Format tanggal menjadi "Tanggal Bulan Tahun"
      String formattedDate = DateFormat('d-MM-y').format(selectedDate);
      tanggal.text =
          formattedDate; // Update controller dengan tanggal yang diformat
    }
  }

  Future<void> getCurrentLocation() async {
    isLoading.value = true;
    Get.snackbar('Loading', 'Mengambil lokasi...');
    // Meminta izin lokasi
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        Get.snackbar('Error', 'Permission denied');
        return;
      }
    }

    // Mendapatkan posisi
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latitude.value = position.latitude;
    longitude.value = position.longitude;

    // Ambil alamat dari latitude dan longitude
    await getAddressFromLatLng();
    Get.snackbar(
      'Berhasil!',
      "Lokasi berhasil didapatkan",
    );
    isLoading.value = false;
  }

  Future<void> getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude.value, longitude.value);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        address.value =
            "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
      } else {
        address.value = "Alamat tidak ditemukan.";
      }
    } catch (e) {
      address.value = "Gagal mendapatkan alamat: $e";
    }
  }

  // Constructor untuk inisialisasi controller
  FormEntryController() {
    // Inisialisasi TextEditingController
    for (var i = 0; i < teks.length; i++) {
      control.add(TextEditingController());
    }
    loadData(); // Memanggil fungsi loadData saat controller diinisialisasi
  }

  // Fungsi untuk menyimpan data ke SharedPreferences
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < teks.length; i++) {
      await prefs.setString('form_data_$i', control[i].text);
    }
    await prefs.setString('tanggal', tanggal.text);
    await prefs.setString('lokasi', lokasi.text);
    await prefs.setString('imagePath', imagePath.value);
  }

  // Fungsi untuk memuat data dari SharedPreferences
  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < teks.length; i++) {
      String? value = prefs.getString('form_data_$i');
      if (value != null) {
        control[i].text = value;
      }
    }
    tanggal.text = prefs.getString('tanggal') ?? '';
    lokasi.text = prefs.getString('lokasi') ?? '';
    imagePath.value = prefs.getString('imagePath') ?? '';
  }

  // Fungsi untuk menghapus semua data
  Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < teks.length; i++) {
      await prefs.remove('form_data_$i');
    }
    await prefs.remove('tanggal');
    await prefs.remove('lokasi');
    await prefs.remove('imagePath');
  }

  void setImage(String path) {
    imagePath.value = path;
  }

  bool validateInput() {
    String nik = control[0].text;
    String nama = control[1].text;
    String noHP = control[2].text;

    // Reset error messages
    errorMessages.assignAll(["", "", ""]);
    errtangal.value = '';
    errImagePath.value = '';
    errAlamat.value = '';

    if (nik.isEmpty) {
      errorMessages[0] = 'NIK harus diisi';
    } else if (!isNumeric(nik) || nik.length != 16) {
      errorMessages[0] = 'NIK harus berupa angka dengan 16 digit';
    }

    if (nama.isEmpty) {
      errorMessages[1] = 'Nama harus diisi';
    }

    if (noHP.isEmpty) {
      errorMessages[2] = 'No. HP harus diisi';
    } else if (!isNumeric(noHP) || noHP.length < 10 || noHP.length > 14) {
      errorMessages[2] =
          'No. HP harus berupa angka dan berisi 10 hingga 14 digit';
    }

    if (tanggal.text.isEmpty) {
      errtangal.value = 'Tangal harus diisi';
    }
    if (address.value.isEmpty) {
      errAlamat.value = 'Alamat harus diisi';
    }
    if (imagePath.value.isEmpty) {
      errImagePath.value = 'Gambar harus diisi';
    }

    // Kembalikan true jika tidak ada error
    return errorMessages.every((error) => error.isEmpty);
  }

  bool isNumeric(String str) {
    if (str.isEmpty) return false;
    return double.tryParse(str) != null;
  }

  Future<void> saveDataToSQLite() async {
    String nik = control[0].text;

    // Cek apakah NIK sudah ada di dalam database
    bool nikExists = await _dbHelper.checkIfNikExists(nik);
    if (nikExists) {
      // Ambil ID berdasarkan NIK
      int? id = await _dbHelper.getIdByNik(nik);
      // Navigasi ke halaman detail dengan ID
      Get.toNamed('/detail',
          arguments: id); // Pastikan '/detail' adalah nama route yang sesuai
      return; // Hentikan penyimpanan data jika NIK sudah ada
    }

    // Jika NIK belum ada, simpan data baru
    Map<String, dynamic> formData = {
      'nik': control[0].text,
      'nama': control[1].text,
      'no_hp': control[2].text,
      'jk': selectedValue.value,
      'tanggal': tanggal.text,
      'image_path': imagePath.value,
      'address': address.value,
    };

    await _dbHelper.insertFormEntry(formData);
    Get.snackbar('Success', 'Data berhasil disimpan ke SQLite');

    // Mengosongkan field setelah data disimpan
    for (var controller in control) {
      controller.clear();
    }
    tanggal.clear();
    lokasi.clear();
    imagePath.value = '';
    address.value = '';
  }

  // Fungsi untuk mengambil data dari SQLite
  Future<void> loadDataFromSQLite() async {
    List<Map<String, dynamic>> entries = await _dbHelper.getAllEntries();
    if (entries.isNotEmpty) {
      var data = entries.last; // Mengambil entri terakhir
      control[0].text = data['nik'];
      control[1].text = data['nama'];
      control[2].text = data['no_hp'];
      tanggal.text = data['tanggal'];
      lokasi.text = data['lokasi'];
      imagePath.value = data['image_path'];
      address.value = data['address'];
    }
  }

  // Fungsi untuk menghapus semua data dari SQLite
  Future<void> clearSQLiteData() async {
    await _dbHelper.deleteAllEntries();
    Get.snackbar('Success', 'Semua data berhasil dihapus dari SQLite');
  }
}
