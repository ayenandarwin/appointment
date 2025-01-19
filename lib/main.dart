// import 'package:appointment_manager/screen/appointment_list_screen.dart';
// import 'package:appointment_manager/utils/constants.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Constant.textColor),
//         useMaterial3: true,
//       ),
//       home: AppointmentListScreen(),
//     );
//   }
// }

import 'package:appointment_manager/screen/user_api_intergration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/user_new.dart';
import 'provider/appointment_provider.dart';
import 'screen/user_view.dart';
import 'utils/constants.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite CRUD',
      debugShowCheckedModeBanner: false,
      home: UserListScreen(),
      //home: HomeScreen(),
    );
  }
}
