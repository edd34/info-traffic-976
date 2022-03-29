class AlertTable {
  AlertTable(
    this.category,
    this.alertType,
    this.alertSubtype,
  );

  AlertTable.fromJson(Map<String, dynamic> _json)
      : category = _json['category'] as String,
        alertType = _json['alert_type'] as String,
        alertSubtype = _json['alert_subtype'] as String;

  String category = '';
  String alertType = '';
  String alertSubtype = '';

  @override
  String toString() {
    return 'AlertTable: {category: $category, alertType: $alertType, alertSubtype: $alertSubtype}';
  }
}
