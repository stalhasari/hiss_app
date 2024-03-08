import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Location location = Location();
  LatLng? _currentP;

  @override
  void initState() {
    super.initState();
    _setInitialCameraPosition();
  }

  Future<void> _setInitialCameraPosition() async {
    LocationData currentLocation = await location.getLocation();
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          zoom: 15.0,
        ),
      ),
    );
    setState(() {
      _currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      initialCameraPosition: const CameraPosition(
        target: LatLng(40.655381, 35.836891),
        zoom: 15.0,
      ),
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
      },
      markers: _currentP != null
          ? {
              Marker(
                markerId: const MarkerId('myLocation'),
                position: _currentP!,
                infoWindow: const InfoWindow(title: 'Ben buradayım'),
              ),
            }
          : {},
    );
  }
}
