import 'package:flutter/foundation.dart';
import 'package:info_traffic_976/alert/models/alert_table.dart';

class AlertProvider extends ChangeNotifier {
  List<AlertTable> _alertTable = [];
  bool _isAlertTableLoading = true;
  bool _shouldRefresh = true;

  bool get shoudRefresh => _shouldRefresh;
  void setShouldRefresh({required bool value}) => {_shouldRefresh = value};

  bool get isAlertLoading => _isAlertTableLoading;
  void setIsAlertLoading({required bool value}) {
    _isAlertTableLoading = value;
    notifyListeners();
  }

  List<AlertTable> get alertTable => _alertTable;
  void setAlertTable(List<AlertTable> list, {bool notify = true}) {
    _alertTable = list;
    if (notify) notifyListeners();
  }

  Map<String, List<AlertTable>> get mapCategoryToAlertTable {
    final result = <String, List<AlertTable>>{};
    for (final item in alertTable) {
      if (result.containsKey(item.category)) {
        result[item.category]!.add(item);
      } else {
        result[item.category] = [];
        result[item.category]!.add(item);
      }
    }
    return result;
  }

  int get alertTableLength => _alertTable.length;
  bool get alertTableIsEmpty => _alertTable.isEmpty;
}
