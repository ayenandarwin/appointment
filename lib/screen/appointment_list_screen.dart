import 'package:appointment_manager/api_service/api_service.dart';
import 'package:appointment_manager/screen/createAppointment.dart';
import 'package:appointment_manager/screen/map_screen.dart';
import 'package:appointment_manager/utils/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:appointment_manager/db/appointment_db.dart';
import 'package:appointment_manager/models/appointment.dart';

import '../provider/user_provider.dart';
import '../view/appointment_list.dart';
import 'appointment_detail_screen.dart';

class AppointmentListScreen extends StatefulWidget {
  @override
  _AppointmentListScreenState createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final APIservices apiService = APIservices();

  List<Appointment> appointments = [];

  late Future<List<Appointment>> _appointmentsList;
  bool _isConnected = false;
  @override
  void initState() {
    super.initState();
    // _loadAppointments();

    _checkConnection();

    // Listen to connectivity changes
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      _updateConnectionStatus(result);
    });
    Future.delayed(Duration(seconds: 2)).then((value) {
      if (_isConnected) {
        _loadAppointments();
      } else {
        _loadAppointmentsFromLocal();
      }
    });
  }

  _loadAppointments() async {
    try {
      List<Appointment> fetchedAppointments =
          await apiService.getAppointments();
      setState(() {
        appointments = fetchedAppointments;
      });
    } catch (e) {
      // Handle error
      print("Error loading appointments: $e");
    }
  }

  _loadAppointmentsFromLocal() async {
    try {
      List<Appointment> fetchedAppointments =
          await AppointmentDatabase.instance.readAllAppointments();
      setState(() {
        appointments = fetchedAppointments;
      });
    } catch (e) {
      // Handle error
      print("Error loading appointments: $e");
    }
  }

  // _createAppointment() async {
  //   Appointment newAppointment = Appointment(
  //       id: 1,
  //       title: "Jane Doe",
  //       description: 'testing',
  //       date: "2025-01-21",
  //       location: "32222",
  //       company: 'IT',
  //       customer_name: 'ma ma');
  //   // Appointment(id: 2, title: "test two", description: 'testing1',date: "2025-01-21", location: "322200",company: 'Sale',customer_name: 'mg mg');
  //   try {
  //     Appointment createdAppointment =
  //         await apiService.createAppointment(newAppointment);
  //     setState(() {
  //       appointments.add(createdAppointment);
  //     });
  //   } catch (e) {
  //     print("Error creating appointment: $e");
  //   }
  // }

  // _updateAppointment(Appointment appointment) async {
  //   Appointment updatedAppointment = Appointment(
  //       id: appointment.id,
  //       title: "Jane Doe",
  //       description: 'testing',
  //       date: "2025-01-21",
  //       location: "32222",
  //       company: 'IT',
  //       customer_name: 'ma ma');
  //   try {
  //     Appointment updated =
  //         await apiService.updateAppointment(updatedAppointment);
  //     setState(() {
  //       appointments[appointments.indexWhere((a) => a.id == appointment.id)] =
  //           updated;
  //     });
  //   } catch (e) {
  //     print("Error updating appointment: $e");
  //   }
  // }

  // _createAppointment() async {
  //   if (_formKey.currentState!.validate()) {
  //     // Collect dynamic data from the controllers
  //     Appointment newAppointment = Appointment(
  //       id: 0, // ID will be auto-generated by the backend
  //       title: _titleController.text,
  //       description: _descriptionController.text,
  //       date: _dateController.text,
  //       location: _locationController.text,
  //       company: _companyController.text,
  //       customer_name: _customerNameController.text,
  //     );

  //     try {
  //       // Create the appointment using your API service
  //       Appointment createdAppointment =
  //           await apiService.createAppointment(newAppointment);

  //       // If successful, add the new appointment to the list
  //       setState(() {
  //         appointments.add(createdAppointment);
  //       });

  //       // Clear the form fields after successful creation
  //       _titleController.clear();
  //       _descriptionController.clear();
  //       _dateController.clear();
  //       _locationController.clear();
  //       _companyController.clear();
  //       _customerNameController.clear();
  //     } catch (e) {
  //       // Handle any errors during the API call
  //       print("Error creating appointment: $e");
  //     }
  //   }
  // }

  _deleteAppointment(int id) async {
    try {
      await apiService.deleteAppointment(id);
      setState(() {
        appointments.removeWhere((appointment) => appointment.id == id);
      });
    } catch (e) {
      print("Error deleting appointment: $e");
    }
  }
  //}

  fetchAppointments() {
    _appointmentsList = APIservices().getAppointments();
  }

  // _updateAppointment(Appointment appointment) async {
  //   Appointment updatedAppointment = Appointment(
  //       id: appointment.id,
  //       title: "Jane Doe",
  //       description: 'testing',
  //       date: "2025-01-21",
  //       location: "32222",
  //       company: 'IT',
  //       customer_name: 'ma ma');
  //   try {
  //     Appointment updated =
  //         await apiService.updateAppointment(updatedAppointment);
  //     setState(() {
  //       appointments[appointments.indexWhere((a) => a.id == appointment.id)] =
  //           updated;
  //     });
  //   } catch (e) {
  //     print("Error updating appointment: $e");
  //   }
  // }

  _updateAppointment(Appointment appointment,
      {String? title,
      String? description,
      String? date,
      String? location,
      String? company,
      String? customer_name}) async {
    // Use the passed arguments if they are not null, otherwise keep the existing values
    Appointment updatedAppointment = Appointment(
      id: appointment.id,
      title: title ??
          appointment
              .title, // Use the existing title if no new value is provided
      description:
          description ?? appointment.description, // Same for description
      date: date ?? appointment.date,
      location: location ?? appointment.location,
      company: company ?? appointment.company,
      customer_name: customer_name ?? appointment.customer_name,
    );

    try {
      // Call the API service to update the appointment
      Appointment updated =
          await apiService.updateAppointment(updatedAppointment);

      setState(() {
        // Update the appointment in the list with the updated data
        appointments[appointments.indexWhere((a) => a.id == appointment.id)] =
            updated;
      });
    } catch (e) {
      print("Error updating appointment: $e");
    }
  }

  // Delete appointment
  // void _deleteAppointment(int id) async {
  //   await AppointmentDatabase.instance.delete(id);
  //   setState(() {
  //     _appointmentsList = AppointmentDatabase.instance.readAllAppointments();
  //   });
  // }

  // Navigate to Appointment Detail Screen
  void _navigateToAppointmentDetail({Appointment? appointment}) async {
    // final result = await
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppointmentDetailScreen(
          appointment: appointment,
        ),
      ),
    );

    // if (result != null && result is Appointment) {
    //   setState(() {
    //     _appointments = AppointmentDatabase.instance.readAllAppointments();
    //   });
    // }
  }

  // Function to check internet connection and update UI
  Future<void> _checkConnection() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }

  // Update the connection status based on the result
  void _updateConnectionStatus(List<ConnectivityResult> result) {
    setState(() {
      _isConnected = result != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final users = ref.watch(userListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointments',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Constant.textColor,
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text(appointment.title),
                subtitle: Text('${appointment.date} - ${appointment.date}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Constant.textColor,
                      ),
                      onPressed: () => _updateAppointment(appointment),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () => _deleteAppointment(appointment.id!),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      // FutureBuilder<List<Appointment>>(
      //   future: _appointmentsList,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //     if (snapshot.hasError) {
      //       return Center(child: Text('Error: ${snapshot.error}'));
      //     }
      //     if (!snapshot.hasData || snapshot.data!.isEmpty) {
      //       return Center(child: Text('No appointments available.'));
      //     }

      //     final appointments = snapshot.data!;

      //     return ListView.builder(
      //       itemCount: appointments.length,
      //       itemBuilder: (context, index) {
      //         final appointment = appointments[index];
      //         return Card(
      //           child: ListTile(
      //             title: Text(appointment.title),
      //             subtitle: Text(appointment.description),
      //             trailing: Row(
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //                 IconButton(
      //                     icon: Icon(Icons.edit),
      //                     onPressed: () {
      //                       _navigateToAppointmentDetail(
      //                           appointment: appointment);
      //                     }),
      //                 IconButton(
      //                   icon: Icon(Icons.delete),
      //                   onPressed: () => _deleteAppointment(appointment.id),
      //                 ),
      //               ],
      //             ),
      //             onTap: () =>
      //                 _navigateToAppointmentDetail(appointment: appointment),
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        // onPressed: () => _navigateToAppointmentDetail(),

        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AppointmentScreen(
                    totalAppointment: appointments.length,
                  )
              //MapScreen(),
              ),
        ).then((value) {
          _loadAppointments();
        }),
        // onPressed: _createAppointment,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
