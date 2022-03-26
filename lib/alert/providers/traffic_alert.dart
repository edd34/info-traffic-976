import 'package:flutter/foundation.dart';
import 'package:info_traffic_976/alert/models/traffic_alert.dart';

class TrafficAlertProvider extends ChangeNotifier {
  List<TrafficAlert> _TrafficAlert = [];
  bool _isTrafficAlertLoading = true;
  bool _shouldRefresh = true;

  bool get shoudRefresh => _shouldRefresh;
  void setShouldRefresh({required bool value}) => {_shouldRefresh = value};

  bool get isAlertLoading => _isTrafficAlertLoading;
  void setIsAlertLoading({required bool value}) {
    _isTrafficAlertLoading = value;
    notifyListeners();
  }

  List<TrafficAlert> get trafficAlert => _TrafficAlert;
  void setTrafficAlert(List<TrafficAlert> list, {bool notify = true}) {
    _TrafficAlert = list;
    if (notify) notifyListeners();
  }

  int get trafficAlertLength => _TrafficAlert.length;
  bool get trafficAlertIsEmpty => _TrafficAlert.isEmpty;
}
