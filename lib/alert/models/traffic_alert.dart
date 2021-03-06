class TrafficAlert {
  TrafficAlert(
    this.lat,
    this.lon,
  );

  TrafficAlert.fromJson(Map<String, dynamic> _json) {
    lat = double.tryParse(_json['lat'] as String) as double;
    lon = double.tryParse(_json['lon'] as String) as double;
  }

  double lat = 0;
  double lon = 0;

  @override
  String toString() {
    return 'TrafficAlert: {lat: $lat, lon: $lon}';
  }
}
