import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

// Dio instance provider
final dioProvider = Provider((ref) => Dio(BaseOptions(baseUrl: 'http://localhost:3000')));

// Users State Provider
final usersProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final dio = ref.read(dioProvider);
  final response = await dio.get('/users');
  return List<Map<String, dynamic>>.from(response.data);
});

// Main App
// void main() {
//   runApp(ProviderScope(child: MyApp()));
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter JSON Server CRUD',
//       home: HomeScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsyncValue = ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite CRUD'),
      ),
      body: usersAsyncValue.when(
        data: (users) => users.isEmpty
            ? Center(child: Text('No Users Found'))
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text(user['name']),
                    subtitle: Text(user['description']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            // Handle Edit
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final dio = ref.read(dioProvider);
                            await dio.delete('/users/${user['id']}');
                            ref.refresh(usersProvider);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddUserScreen()),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddUserScreen extends ConsumerWidget {
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _contactController,
              decoration: InputDecoration(labelText: 'Contact'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final dio = ref.read(dioProvider);
                    await dio.post('/users', data: {
                      "name": _nameController.text,
                      "contact": _contactController.text,
                      "description": _descriptionController.text,
                    });
                    ref.refresh(usersProvider);
                    Navigator.pop(context);
                  },
                  child: Text('Save Details'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _nameController.clear();
                    _contactController.clear();
                    _descriptionController.clear();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Clear Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
