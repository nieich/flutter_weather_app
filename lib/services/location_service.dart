import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logging/logging.dart';

class LocationService {
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
  Future<Placemark> getPlacemark(double latitude, double longitude) async {
    final Logger logger = Logger('LocationService');
    try {
      logger.info('Fetching placemark for lat: $latitude, lon: $longitude');

      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      // The first placemark is usually the most relevant.
      return placemarks.first;
    } catch (e) {
      // Handle potential errors, e.g., network issues or no results found.
      throw Exception('Failed to get placemark: $e');
    }
  }
}
