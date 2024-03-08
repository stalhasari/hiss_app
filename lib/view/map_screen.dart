import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kTurkey = CameraPosition(
    target: LatLng(39.9208, 32.8541), // Türkiye'nin koordinatları
    zoom: 6, // Yakınlaştırma seviyesi
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kTurkey, // Türkiye koordinatlarına göre başlangıç konumu
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: _goToTurkey, // Türkiye'ye gitmek için butona basıldığında çalışacak metot
            label: const Text('Türkiye\'ye git!'),
            icon: const Icon(Icons.directions_boat),
          ),
          const SizedBox(height: 16), // Boşluk ekleyin
          
        ],
      ),
    );
  }

  Future<void> _goToTurkey() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kTurkey));
  }
}
