import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'form_entry.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE form_entries(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nik TEXT,
            nama TEXT,
            no_hp TEXT,
            jk TEXT,
            tanggal TEXT,
            image_path TEXT,
            address TEXT
          )
          ''',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < newVersion) {
          await db.execute('ALTER TABLE form_entries ADD COLUMN jk TEXT');
        }
      },
    );
  }

  Future<int?> getIdByNik(String nik) async {
    final db = await database; // Mendapatkan instance database
    final List<Map<String, dynamic>> maps = await db.query(
      'form_entries', // Nama tabel
      columns: ['id'], // Kolom yang ingin diambil
      where: 'nik = ?',
      whereArgs: [nik],
    );

    if (maps.isNotEmpty) {
      return maps.first['id']; // Mengembalikan ID dari entri pertama
    }
    return null; // Mengembalikan null jika tidak ditemukan
  }

  // Fungsi untuk menyimpan data
  Future<int> insertFormEntry(Map<String, dynamic> data) async {
    Database db = await database;
    return await db.insert('form_entries', data);
  }

  // Fungsi untuk mengambil semua data
  Future<List<Map<String, dynamic>>> getAllEntries() async {
    Database db = await database;
    return await db.query('form_entries');
  }

  Future<bool> checkIfNikExists(String nik) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'form_entries', // Nama tabel
      where: 'nik = ?',
      whereArgs: [nik],
    );
    return results.isNotEmpty;
  }

  // Fungsi untuk menghapus data
  Future<int> deleteAllEntries() async {
    Database db = await database;
    return await db.delete('form_entries');
  }

  // Fungsi untuk menutup database
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null; // Reset database instance
  }
}
