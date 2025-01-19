import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/appointment.dart';

const apiKey = "f95a6d45558dee5ab593965b75e80dfd";

class APIservices {
  // Corrected baseUrl with the http:// prefix
  final baseUrl = "http://192.168.100.4:3000/appointments";
  //final baseUrl = "http://localhost:3000/appointments";
  // final baseUrl = "https://mockapi.com/appointments";

  Future<List<Appointment>> getAppointments() async {
    Uri url = Uri.parse(baseUrl);
    final response = await http.get(url);

    print("Response>> ${response.body}");

    if (response.statusCode == 200) {
      log("Response Now appointments.>> ${response.body}");

      // Assuming the response is a list of appointments
      final List<dynamic> data = json.decode(response.body);

      // Map the data to List<Appointment>
      List<Appointment> appointments =
          data.map((appointment) => Appointment.fromMap(appointment)).toList();

      return appointments;
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<Appointment> createAppointment(Appointment appointment) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(appointment.toMap()), // toJson will now work
    );
    if (response.statusCode == 201) {
      return Appointment.fromMap(json.decode(response.body));
    } else {
      throw Exception('Failed to create appointment');
    }
  }

  Future<Appointment> updateAppointment(Appointment appointment) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${appointment.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(appointment.toMap()),
    );
    if (response.statusCode == 200) {
      return Appointment.fromMap(json.decode(response.body));
    } else {
      throw Exception('Failed to update appointment');
    }
  }

  Future<void> deleteAppointment(int id) async {
    // final url = Uri.parse('$baseUrl/id');

    // // Print the URL to ensure it's correct
    // print('Deleting appointment with URL: $url');

    // final response = await http.delete(url);

  final url = 'http://192.168.100.4:3000/appointments/$id'; // Using string interpolation

  final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      print('Appointment deleted successfully');
    } else {
      // Print the response body to see any error message
      print('Failed to delete appointment: ${response.body}');
      throw Exception('Failed to delete appointment');
    }
  }
}
