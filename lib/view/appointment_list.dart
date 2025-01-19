// import 'package:flutter/material.dart';

// class AppointmentListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Appointments')),
//       body: AppointmentListScreen(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AppointmentDetailScreen()),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// class AppointmentDetailScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Appointment Details')),
//       body: Column(
//         children: [
          
//           TextField(
//             decoration: InputDecoration(labelText: 'Title'),
//           ),
//           TextField(
//             decoration: InputDecoration(labelText: 'Description'),
//           ),
//           ElevatedButton(
//             onPressed: () {},
//             child: Text('Save Appointment'),
//           ),
//         ],
//       ),
//     );
//   }
// }
