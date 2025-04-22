import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Future<void> getCurrentLocation(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Verifica se o serviço de localização está ativado
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Serviço de localização está desativado.')),
    );
    return;
  }

  // Verifica permissão
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permissão de localização negada.')),
      );
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Permissão permanentemente negada.')),
    );
    return;
  }

  // Obtem a posição atual
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'Localização: (${position.latitude}, ${position.longitude})',
      ),
    ),
  );
}
