import 'package:appointment_manager/db_helper/database_user.dart';
import 'package:appointment_manager/models/user_new.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';





final appointListProvider = StateNotifierProvider<AppointListNotifier, List<Appoint>>((ref) {
  return AppointListNotifier();
});

class AppointListNotifier extends StateNotifier<List<Appoint>> {
  final DatabaseHelperAppoint _dbHelper = DatabaseHelperAppoint();

  AppointListNotifier() : super([]) {
    loadAppoints();
  }

  Future<void> loadAppoints() async {
    state = await _dbHelper.getAppoints();
  }

  Future<void> addAppoint(Appoint Appoint) async {
    await _dbHelper.insertAppoint(Appoint);
    await loadAppoints();
  }

  Future<void> updateAppoint(Appoint Appoint) async {
    await _dbHelper.updateAppoints(Appoint);
    await loadAppoints();
  }

  Future<void> deleteAppoint(int id) async {
    await _dbHelper.deleteAppoints(id);
    await loadAppoints();
  }
}
