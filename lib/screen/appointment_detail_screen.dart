import 'package:flutter/material.dart';
import 'package:appointment_manager/models/appointment.dart';
import 'package:intl/intl.dart';
import 'package:appointment_manager/db/appointment_db.dart';

class AppointmentDetailScreen extends StatefulWidget {
  final Appointment? appointment;

  AppointmentDetailScreen({required this.appointment});

  @override
  _AppointmentDetailScreenState createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;
  late TextEditingController _locationController;
  late DateTime _appointmentDate;

  @override
  void initState() {
    super.initState();
    if (widget.appointment != null) {
      _titleController =
          TextEditingController(text: widget.appointment?.title ?? '');

      _descriptionController =
          TextEditingController(text: widget.appointment?.description ?? '');
      _dateController =
          TextEditingController(text: widget.appointment!.date ?? '');
      // TextEditingController(
      //     text: DateFormat('yyyy-MM-dd').format(widget.appointment!.date) ??
      // '');
      _locationController =
          TextEditingController(text: widget.appointment?.location ?? '');
      // _appointmentDate = widget.appointment!.date;
    } else {
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
      _dateController = TextEditingController();
      _locationController = TextEditingController();
      _appointmentDate = DateTime.now();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  // Save the appointment
  void _saveAppointment() {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final location = _locationController.text;

    if (title.isEmpty || description.isEmpty || location.isEmpty) {
      return;
    }

    final appointment = Appointment(
      id: widget.appointment?.id ?? 0,
      title: title,
      description: description,
      date: "",
      // _appointmentDate,
      location: location,
      company: '',
      customer_name: '',
    );

    if (widget.appointment == null) {
      AppointmentDatabase.instance.create(appointment);
    } else {
      AppointmentDatabase.instance.update(appointment);
    }

    Navigator.pop(context, appointment);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _appointmentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _appointmentDate) {
      setState(() {
        _appointmentDate = pickedDate;
        _dateController.text =
            DateFormat('yyyy-MM-dd').format(_appointmentDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("AppointmentDetail>>> ${widget.appointment}");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appointment == null
            ? 'Create Appointment'
            : 'Edit Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title')),
            TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description')),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                    controller: _dateController,
                    decoration: InputDecoration(labelText: 'Date')),
              ),
            ),
            TextField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveAppointment,
              child: Text(widget.appointment == null
                  ? 'Create Appointment'
                  : 'Update Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
