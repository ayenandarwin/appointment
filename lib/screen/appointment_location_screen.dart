import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppointmentLocationScreen extends StatefulWidget {
  final Function(LatLng) onLocationSelected;

  AppointmentLocationScreen({required this.onLocationSelected});

  @override
  _AppointmentLocationScreenState createState() => _AppointmentLocationScreenState();
}

class _AppointmentLocationScreenState extends State<AppointmentLocationScreen> {
  late GoogleMapController _mapController;
  late LatLng _selectedLocation;

  @override
  void initState() {
    super.initState();
    _selectedLocation = LatLng(37.42796133580664, -122.085749655962); // Default to a location
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onTap(LatLng position) {
    setState(() {
      _selectedLocation = position;
    });
    widget.onLocationSelected(_selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Location')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _selectedLocation, zoom: 14),
        onMapCreated: _onMapCreated,
        onTap: _onTap,
        markers: {
          Marker(markerId: MarkerId('location'), position: _selectedLocation),
        },
      ),
    );
  }
}
