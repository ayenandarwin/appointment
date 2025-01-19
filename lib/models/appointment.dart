// class Appointment {
//   final int id;
//   final String title;
//   final String description;
//   final String date;
//   //final DateTime date;
//   final String customer_name;
//   final String company;
//   final String location; // This will store the address or location description

//   Appointment(
//       {required this.id,
//       required this.title,
//       required this.description,
//       required this.date,
//       required this.location,
//       required this.company,
//       required this.customer_name});

//   // Convert Appointment object to a Map (for SQLite database)
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//       'date':
//           date,
//          // date.toIso8601String(),
//       'location': location,
//     };
//   }

//   // Convert Map to Appointment object
//   factory Appointment.fromMap(Map<String, dynamic> map) {
//     return Appointment(
//         id: map['id'],
//         title: map['title'],
//         description: map['description'],
//         date: map['date_time'],
//         //date: DateTime.parse(map['date_time']),
//         location: map['location'],
//         customer_name: map['customer_name'],
//         company: map['company']);
//   }
// }


class Appointment {
  final int id;
  final String title;
  final String description;
  final String date;
  final String customer_name;
  final String company;
  final String? location;  // Mark location as nullable if it can be null

  Appointment({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.customer_name,
    required this.company,
    this.location,  // Optional field
  });

  // Convert Appointment object to a Map (for SQLite database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'location': location,  // Nullable
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date_time'] ?? '',
      location: map['location'],  // Nullable field (no default value needed)
      customer_name: map['customer_name'] ?? '',
      company: map['company'] ?? '',
    );
  }
}




