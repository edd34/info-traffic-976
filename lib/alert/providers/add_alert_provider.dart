import 'package:flutter/foundation.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:info_traffic_976/alert/models/alert_table.dart';

class AddAlertProvider extends ChangeNotifier {
  late GeoPoint _currentPosition;
  late AlertTable _selectedAlert;
  bool _completed = false;
  int _currentTabIndex = 0;

  int get currentTabIndex => _currentTabIndex;
  AlertTable get selectedAlert => _selectedAlert;
  bool get completed => _completed;
  GeoPoint get currentPosition => _currentPosition;

  void resetCurrentTabIndex() => {_currentTabIndex = 0};
  void goNextTabIndex() => {_currentTabIndex++};
  void goPreviousTabIndex() => {_currentTabIndex--};

  void setCompleted() => {_completed = true};
  void resetCompleted() => {_completed = false};
  void setCurrentAlert({required AlertTable value}) => {_selectedAlert = value};
  void setCurrentPosition({required GeoPoint value}) =>
      {_currentPosition = value};
}
