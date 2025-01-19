import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_new.dart';
import '../provider/appointment_provider.dart';
import '../utils/constants.dart';

class AppointListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final users = ref.watch(userListProvider);
    final appointments = ref.watch(appointListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointment',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Constant.textColor,
      ),
      body:
          // users.isEmpty
          appointments.isEmpty
              ? Center(child: Text('No users found'))
              : ListView.builder(
                  // itemCount: users.length,
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    //final user = users[index];
                    final user = appointments[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: Card(
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text(user.name ?? ''),
                          subtitle: Text(user.company ?? ''),
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
                                      //.read(userListProvider.notifier)
                                      .read(appointListProvider.notifier)
                                      .deleteAppoint(user.id!);
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

  //void _showUserDialog(BuildContext context, WidgetRef ref, {User? user}) {
  void _showUserDialog(BuildContext context, WidgetRef ref, {Appoint? user}) {
    final titleController = TextEditingController(text: user?.title ?? '');
    final nameController = TextEditingController(text: user?.name ?? '');
    final companyController = TextEditingController(text: user?.company ?? '');
    final dateController = TextEditingController(text: user?.date ?? '');
    final locationController =
        TextEditingController(text: user?.location ?? '');
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
              // TextField(
              //     controller: titleController,
              //     decoration: InputDecoration(labelText: 'Title')),
              TextField(
                  controller: companyController,
                  decoration: InputDecoration(labelText: 'Company')),
              TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description')),
              // TextField(
              //     controller: dateController,
              //     decoration: InputDecoration(labelText: 'Date & Time')),
              // TextField(
              //     controller: locationController,
              //     decoration: InputDecoration(labelText: 'Location')),
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
                // final newUser = User(
                final newUser = Appoint(
                  id: user?.id,
                  title: titleController.text,
                  name: nameController.text,
                  company: companyController.text,
                  description: descriptionController.text,
                  date: dateController.text,
                  location: locationController.text,
                );

                if (user == null) {
                  //  ref.read(userListProvider.notifier).addUser(newUser);
                  ref.read(appointListProvider.notifier).addAppoint(newUser);
                } else {
                  //  ref.read(userListProvider.notifier).updateUser(newUser);
                  ref.read(appointListProvider.notifier).updateAppoint(newUser);
                }
                // if (user == null) {
                //   ref.read(userListProvider.notifier).addUser(newUser);
                // } else {
                //   ref.read(userListProvider.notifier).updateUser(newUser);
                // }

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
