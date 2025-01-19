import 'package:appointment_manager/db_helper/database_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';


final dioProvider = Provider((ref) => Dio(BaseOptions(baseUrl: 'http://localhost:3000')));


final userListProvider = StateNotifierProvider<UserListNotifier, List<User>>((ref) {
  return UserListNotifier();
});

class UserListNotifier extends StateNotifier<List<User>> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  UserListNotifier() : super([]) {
    loadUsers();
  }

  Future<void> loadUsers() async {
    state = await _dbHelper.getUsers();
  }

  Future<void> addUser(User user) async {
    await _dbHelper.insertUser(user);
    await loadUsers();
  }

  Future<void> updateUser(User user) async {
    await _dbHelper.updateUser(user);
    await loadUsers();
  }

  Future<void> deleteUser(int id) async {
    await _dbHelper.deleteUser(id);
    await loadUsers();
  }
}
