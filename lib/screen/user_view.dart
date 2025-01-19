import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import '../provider/user_provider.dart';
import '../utils/constants.dart';

class UserListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userListProvider);
    

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointment',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Constant.textColor,
      ),
      body:
       users.isEmpty
       

          ? Center(child: Text('No users found'))
          : ListView.builder(
              itemCount: users.length,
              
              itemBuilder: (context, index) {
                final user = users[index];
                
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(user.name ?? ''),
                      subtitle: Text(user.contact ?? ''),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Constant.textColor,
                            ),
                            onPressed: () {
                              _showUserDialog(context, ref, user: user);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              ref
                                  .read(userListProvider.notifier)
                                  
                                  .deleteUser(user.id!);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constant.textColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          _showUserDialog(context, ref);
        },
      ),
    );
  }

  void _showUserDialog(BuildContext context, WidgetRef ref, {User? user}) {

    final nameController = TextEditingController(text: user?.name ?? '');
    final companyController = TextEditingController(text: user?.contact ?? '');
    
    final descriptionController =
        TextEditingController(text: user?.description ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(user == null ? 'Add New User' : 'Edit User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name')),
             
              TextField(
                  controller: companyController,
                  decoration: InputDecoration(labelText: 'Company')),
              TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description')),
              
            ],
          ),
          actions: [
            OutlinedButton(
              child: Text(
                'Cancel',
              ),
              style: OutlinedButton.styleFrom(
                // backgroundColor: Constant.textColor, // Set the background color
                foregroundColor: Constant.textColor, // Set the text color
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Constant.secondColor, // Set the background color
                foregroundColor: Colors.white, // Set the text color
              ),
              child: Text(user == null ? 'Save' : 'Update'),
              onPressed: () {
                final newUser = User(
              
                  id: user?.id,
                 
                  name: nameController.text,
                  contact: companyController.text,
                  description: descriptionController.text,
                 
                );

                if (user == null) {
                  ref.read(userListProvider.notifier).addUser(newUser);
                } else {
                  ref.read(userListProvider.notifier).updateUser(newUser);
                }
               

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}