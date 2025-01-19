import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:appointment_manager/models/appointment.dart';

class AppointmentDatabase {
  static final AppointmentDatabase instance = AppointmentDatabase._init();
  static Database? _database;

  AppointmentDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('appointments.db');
    return _database!;
  }

  Future<Database> _initDB(String path) async {
    final dbPath = await getDatabasesPath();
    final fullPath = join(dbPath, path);
    return openDatabase(fullPath, version: 1, onCreate: _onCreate);
  }

  Future<List<Appointment>> searchAppointments(String query) async {
    final db = await instance.database;
    final result = await db.query(
      'appointments',
      where: 'title LIKE ? OR description LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return result.map((e) => Appointment.fromMap(e)).toList();
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE appointments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        date TEXT,
        location TEXT,
        customer_name TEXT,
        company TEXT,
      )
    ''');
  }

  Future<int> create(Appointment appointment) async {
    final db = await instance.database;
    return await db.insert('appointments', appointment.toMap());
  }

  Future<List<Appointment>> readAllAppointments() async {
    final db = await instance.database;
    final result = await db.query('appointments');
    return result.map((e) => Appointment.fromMap(e)).toList();
  }

  Future<int> update(Appointment appointment) async {
    final db = await instance.database;
    return await db.update(
      'appointments',
      appointment.toMap(),
      where: 'id = ?',
      whereArgs: [appointment.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'appointments',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
