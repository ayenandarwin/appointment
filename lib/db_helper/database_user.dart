// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// import '../models/user_new.dart';

// class DatabaseHelperAppoint {
//   static final DatabaseHelperAppoint _instance =
//       DatabaseHelperAppoint._internal();
//   factory DatabaseHelperAppoint() => _instance;

//   DatabaseHelperAppoint._internal();

//   Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'appointment.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         return db.execute('''
//           CREATE TABLE appointments (
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
            
//             name TEXT,
//             title TEXT,
//             company TEXT,
//             description TEXT,
//             date TEXT,
//             location TEXT,
           
//           )
//         ''');
//       },
//     );
//   }

//   Future<int> insertAppoint(Appoint appointment) async {
//     final db = await database;
//     return await db.insert('appointment', appointment.toMap());
//   }

//   Future<List<Appoint>> getAppoints() async {
//     final db = await database;
//     final result = await db.query('appointments');
//     return result.map((map) => Appoint.fromMap(map)).toList();
//   }

//   Future<int> updateAppoints(Appoint appointment) async {
//     final db = await database;
//     return await db.update('appointment', appointment.toMap(),
//         where: 'id = ?', whereArgs: [appointment.id]);
//   }

//   Future<int> deleteAppoints(int id) async {
//     final db = await database;
//     return await db.delete('appointment', where: 'id = ?', whereArgs: [id]);
//   }
// }
