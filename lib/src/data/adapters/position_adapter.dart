import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PositionAdapter {
  PositionAdapter._();

  static LatLng fromJson(Position data) {
    return LatLng(data.latitude, data.longitude);
  }
}
