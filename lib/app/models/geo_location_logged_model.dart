import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

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
    );
  }

  static Future<String> getAddress(double latitude, double longitude) async {
    try {
      final places = await placemarkFromCoordinates(latitude, longitude);

      if (places.isEmpty) return "";

      final p = places.first;

      return [
        p.name,
        p.street,
        p.subLocality,
        p.locality,
        p.administrativeArea,
        p.postalCode,
        p.country,
      ].where((e) => e != null && e!.isNotEmpty).join(", ");
    } catch (_) {
      return "";
    }
  }

  static Future<GeoLocationLoggedModel?> loadLocation() async {
    GeoLocationLoggedModel geoLocation = const GeoLocationLoggedModel(
      latitude: 0,
      longitude: 0,
      address: "",
    );
    final position = await getPosition();

    if (position == null) {
      return null;
    }

    final address = await getAddress(position.latitude, position.longitude);

    geoLocation = GeoLocationLoggedModel(
      latitude: position.latitude,
      longitude: position.longitude,
      address: address,
    );

    return geoLocation;
  }
}
