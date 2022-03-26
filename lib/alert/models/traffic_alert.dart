class TrafficAlert {
  TrafficAlert(
    this.lat,
    this.lon,
  );

  TrafficAlert.fromJson(Map<String, dynamic> _json) {
    lat = double.tryParse(_json['lat']) as double;
    lon = double.tryParse(_json['lon']) as double;
  }

  double lat = 0;
  double lon = 0;
}
