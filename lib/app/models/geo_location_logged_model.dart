import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class GeoLocationLoggedModel {
  final double latitude;
  final double longitude;
  final String address;

  const GeoLocationLoggedModel({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "address": address,
  };

  static Future<Position?> getPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: Duration(seconds: 20),
    );
  }

  // static Future<String> getAddress(double latitude, double longitude) async {
  //   try {
  //     final places = await placemarkFromCoordinates(latitude, longitude);

  //     if (places.isEmpty) return "";

  //     final p = places.first;

  //     return [
  //       p.name,
  //       p.street,
  //       p.subLocality,
  //       p.locality,
  //       p.administrativeArea,
  //       p.postalCode,
  //       p.country,
  //     ].where((e) => e != null && e!.isNotEmpty).join(", ");
  //   } catch (_) {
  //     return "";
  //   }
  // }

  static Future<String> getAddress(double lat, double lng) async {
    try {
      if (kIsWeb) {
        final url = Uri.parse(
          'https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lng&format=json',
        );
        final response = await http
            .get(url, headers: {'Accept': 'application/json'})
            .timeout(const Duration(seconds: 10));

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          return data['display_name'] ?? 'unknown';
        }
        return 'unavailable';
      }

      // Mobile
      final Geocoding geocoding = Geocoding();
      final placemarks = await geocoding
          .placemarkFromCoordinates(lat, lng)
          .timeout(const Duration(seconds: 10));

      if (placemarks.isEmpty) return 'unavailable';

      final place = placemarks.first;
      return [
        place.street,
        place.subLocality,
        place.locality,
        place.administrativeArea,
        place.country,
      ].where((e) => e != null && e.isNotEmpty).join(', ');
    } catch (e) {
      debugPrint('getAddress error: $e');
      return 'unavailable';
    }
  }

  static Future<GeoLocationLoggedModel> loadLocation() async {
    const fallback = GeoLocationLoggedModel(
      latitude: 0,
      longitude: 0,
      address: 'unavailable',
    );

    try {
      final position = await getPosition().timeout(const Duration(seconds: 15));

      if (position == null) return fallback;

      final address = await getAddress(position.latitude, position.longitude);

      return GeoLocationLoggedModel(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      );
    } catch (e) {
      debugPrint('loadLocation error: $e');
      return fallback;
    }
  }

  // static Future<GeoLocationLoggedModel?> loadLocation() async {
  //   GeoLocationLoggedModel geoLocation = const GeoLocationLoggedModel(
  //     latitude: 0,
  //     longitude: 0,
  //     address: "",
  //   );
  //   final position = await getPosition();

  //   if (position == null) {
  //     return null;
  //   }

  //   final address = await getAddress(position.latitude, position.longitude);

  //   geoLocation = GeoLocationLoggedModel(
  //     latitude: position.latitude,
  //     longitude: position.longitude,
  //     address: address,
  //   );

  //   return geoLocation;
  // }
}
