class AlertTable {
  AlertTable(
    this.id,
    this.category,
    this.alertType,
    this.alertSubtype,
  );

  AlertTable.fromJson(Map<String, dynamic> _json)
      : id = _json['id'] as int,
        category = _json['category'] as String,
        alertType = _json['alert_type'] as String,
        alertSubtype = _json['alert_subtype'] as String;

  String category;
  String alertType;
  String alertSubtype;
  int id;

  @override
  String toString() {
    return 'AlertTable: {id: $id, category: $category, alertType: $alertType, alertSubtype: $alertSubtype}';
  }
}
