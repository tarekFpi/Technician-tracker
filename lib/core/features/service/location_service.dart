import 'package:geolocator/geolocator.dart';

enum LocationStatus {
  SERVICE_DISABLE,
  PERMISSION_DENIED,
  DENIED_PERMANENTLY,
  PERMISSION_OK
}

class LocationService {
  static Future<LocationStatus> getLocationState() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      return LocationStatus.SERVICE_DISABLE;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return LocationStatus.PERMISSION_DENIED;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return LocationStatus.DENIED_PERMANENTLY;
    }


    return LocationStatus.PERMISSION_OK;
  }
}
