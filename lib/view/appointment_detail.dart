// import 'package:appointment_manager/models/appointment_new.dart';
// import 'package:appointment_manager/view/appointment_list.dart';
// import 'package:flutter/material.dart';
// import 'package:appointment_manager/db/appointment_db.dart';
// import 'package:appointment_manager/models/appointment.dart';


// class AppointmentListScreen extends StatefulWidget {
//   @override
//   _AppointmentListScreenState createState() => _AppointmentListScreenState();
// }

// class _AppointmentListScreenState extends State<AppointmentListScreen> {
//   late Future<List<Appointment>> _appointments;

//   @override
//   void initState() {
//     super.initState();
//     _appointments = AppointmentDatabase.instance.readAllAppointments();
//   }

//   // Method to delete an appointment
//   void _deleteAppointment(int id) async {
//     await AppointmentDatabase.instance.delete(id);
//     setState(() {
//       _appointments = AppointmentDatabase.instance.readAllAppointments();
//     });
//   }

//   // Navigate to the appointment detail screen
//   void _navigateToAppointmentDetail({Appointment? appointment}) async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AppointmentDetailScreen(),
//       ),
//     );

//     if (result != null && result is Appointment) {
//       setState(() {
//         _appointments = AppointmentDatabase.instance.readAllAppointments();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Appointments'),
//       ),
//       body: FutureBuilder<List<Appointment>>(
//         future: _appointments,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No appointments available.'));
//           }

//           final appointments = snapshot.data!;

//           return ListView.builder(
//             itemCount: appointments.length,
//             itemBuilder: (context, index) {
//               final appointment = appointments[index];
//               return ListTile(
//                 title: Text(appointment.title),
//                 subtitle: Text(""
//                   // '${appointment.date.toLocal()} | ${appointment.location}',
//                 ),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.edit),
//                       onPressed: () => _navigateToAppointmentDetail(appointment: appointment),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () => _deleteAppointment(appointment.id),
//                     ),
//                   ],
//                 ),
//                 onTap: () => _navigateToAppointmentDetail(appointment: appointment),
//               );
//             },
//           );
//         },
//       ),
      
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _navigateToAppointmentDetail(),
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
