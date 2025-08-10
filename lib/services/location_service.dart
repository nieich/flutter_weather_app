import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class LocationService {
  final _logger = Logger('LocationService');

  /// Bestimmt die aktuelle Position des Geräts.
  ///
  /// Wenn die Standortdienste deaktiviert sind oder die Berechtigungen
  /// verweigert werden, wird eine `Exception` ausgelöst.
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Teste, ob die Standortdienste aktiviert sind.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Standortdienste sind nicht aktiviert. Wir können nicht fortfahren.
      return Future.error('Standortdienste sind deaktiviert.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Berechtigungen wurden verweigert.
        return Future.error('Standortberechtigungen wurden verweigert.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Berechtigungen wurden dauerhaft verweigert.
      return Future.error(
        'Standortberechtigungen sind dauerhaft deaktiviert, wir können keine Berechtigungen anfordern.',
      );
    }

    // Wenn wir hier ankommen, sind die Berechtigungen erteilt und wir können
    // auf die Position des Geräts zugreifen.
    return await Geolocator.getCurrentPosition();
  }

  /// Converts latitude and longitude into a placemark with address details.
  Future<String?> getPlace(double latitude, double longitude, String localeName) async {
    try {
      _logger.info('Fetching placemark for lat: $latitude, lon: $longitude');

      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isEmpty) {
        _logger.warning('No placemarks found for coordinates.');
      }

      // The first placemark is usually the most relevant.
      return placemarks.first.locality ??
          placemarks.first.subAdministrativeArea ??
          placemarks.first.administrativeArea ??
          'Unknown Location';
    } on PlatformException catch (e, stackTrace) {
      _logger.severe('Failed to get placemark.', e, stackTrace);
      return getAddressFromCoordinates(latitude, longitude, localeName);
    } catch (e, stackTrace) {
      _logger.severe('An unexpected error occurred while getting placemark.', e, stackTrace);
      return getAddressFromCoordinates(latitude, longitude, localeName);
    }
  }

  Future<String> getAddressFromCoordinates(double lat, double lon, String localeName) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon&zoom=18&addressdetails=1',
    );

    _logger.info('FALLBACK: Fetching address via openstreetmap for lat: $lat, lon: $lon');
    try {
      final uri = Uri.parse(
        '$url?'
        'latitude=$lat&'
        'longitude=$lon&'
        'current=rain,temperature_2m,precipitation&'
        'timezone=auto',
      );

      // 2. Erstelle eine Map für die Header
      final Map<String, String> headers = {'User-Agent': 'Flutter Weather App', 'Accept-Language': localeName};

      // 3. Füge die Header zum http.get Aufruf hinzu
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        _logger.info('OpenStreetMap response OK');
        final data = json.decode(response.body);

        // Check if the address exists in the response
        if (data['address'] != null) {
          final address = data['address'];
          final String city = address['city'] ?? address['town'] ?? address['village'] ?? '';
          final String country = address['country'] ?? '';

          if (city.isNotEmpty && country.isNotEmpty) {
            _logger.info('Found place:$city');
            return city;
          }
        }
        return 'Location not found';
      } else {
        return 'Error: Could not retrieve address.';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
