import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:info_traffic_976/alert/models/traffic_alert.dart';

class LocalisationProvider extends ChangeNotifier {
  late GeoPoint _currentPosition;

  GeoPoint get currentPosition => _currentPosition;
  void setCurrentPosition({required GeoPoint value}) =>
      {_currentPosition = value};
}