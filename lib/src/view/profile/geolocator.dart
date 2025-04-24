import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Future<void> getCurrentLocation(ScaffoldMessengerState scaffoldMessenger) async {
  bool serviceEnabled;
  LocationPermission permission;


  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    scaffoldMessenger.showSnackBar(
      SnackBar(content: Text('Serviço de localização está desativado.')),
    );
    return;
  }


  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Permissão de localização negada.')),
      );
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    scaffoldMessenger.showSnackBar(
      SnackBar(content: Text('Permissão permanentemente negada.')),
    );
    return;
  }


Position position = await Geolocator.getCurrentPosition(
  locationSettings: LocationSettings(
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
}
