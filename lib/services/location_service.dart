import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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
  Future<Placemark?> getPlacemark(double latitude, double longitude) async {
    try {
      _logger.info('Fetching placemark for lat: $latitude, lon: $longitude');

      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isEmpty) {
        _logger.warning('No placemarks found for coordinates.');
      }

      // The first placemark is usually the most relevant.
      return placemarks.first;
    } on PlatformException catch (e, stackTrace) {
      _logger.severe('Failed to get placemark.', e, stackTrace);
      // IO_ERROR often means no internet connection on Android.
      throw Exception('Failed to get location details. Please check your internet connection and try again.');
    } catch (e, stackTrace) {
      _logger.severe('An unexpected error occurred while getting placemark.', e, stackTrace);
      return null;
    }
  }
}
