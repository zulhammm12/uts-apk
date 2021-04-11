// import 'dart.io';
import 'package:universal_io/io.dart';
import 'package:application/models/contact.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "uascrud.db";
  static const _databaseVersion = 1;

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _databaseName);
    print(dbPath);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE ${Contact.t_patient}(
        ${Contact.f_id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Contact.f_name} TEXT NOT NULL,
        ${Contact.f_alamat} TEXT NOT NULL,
        ${Contact.f_pendidikan} TEXT NOT NULL,
        ${Contact.f_keahlian} TEXT NOT NULL,
        ${Contact.f_pengalaman} TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertContact(Contact data) async {
    Database db = await database;
    return await db.insert(Contact.t_patient, data.toMap());
  }

  Future<int> updateContact(Contact data) async {
    Database db = await database;
    return await db.update(Contact.t_patient, data.toMap(),
        where: '${Contact.f_id}=?', whereArgs: [data.id]);
  }

  Future<int> deleteContact(int id) async {
    Database db = await database;
    return await db
        .delete(Contact.t_patient, where: '${Contact.f_id}=?', whereArgs: [id]);
  }

  Future<List<Contact>> fetchContacts() async {
    Database db = await database;
    List<Map> contacts = await db.query(Contact.t_patient);
    return contacts.length == 0
        ? []
        : contacts.map((e) => Contact.fromMap(e)).toList();
  }
}
