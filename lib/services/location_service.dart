import 'package:geolocator/geolocator.dart';

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
}
