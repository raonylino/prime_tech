import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Future<Position?> getCurrentLocation(ScaffoldMessengerState scaffoldMessenger) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    scaffoldMessenger.showSnackBar(
      SnackBar(content: Text('Serviço de localização está desativado.')),
    );
    return null;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Permissão de localização negada.')),
      );
      return null;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    scaffoldMessenger.showSnackBar(
      SnackBar(content: Text('Permissão permanentemente negada.')),
    );
    return null;
  }

  Position position = await Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
    ),
  );

  scaffoldMessenger.showSnackBar(
    SnackBar(
      content: Text(
        'Localização: (${position.latitude}, ${position.longitude})',
      ),
    ),
  );

  return position;
}
