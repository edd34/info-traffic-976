// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:info_traffic_976/alert/providers/traffic_alert.dart';
import 'package:info_traffic_976/map/cached_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MapView();
  }
}

class MapView extends StatelessWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: MapText()),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => print("gps pressed"),
            child: const Icon(Icons.gps_fixed),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class MapText extends StatelessWidget {
  const MapText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trafficAlertProvider = Provider.of<TrafficAlertProvider>(context);
    return FlutterMap(
      options: MapOptions(
        bounds: LatLngBounds(
            LatLng(-13.005896, 45.011673), LatLng(-12.619567, 45.315170)),
        zoom: 13,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          tileProvider: const CachedTileProvider(),
          subdomains: ['a', 'b', 'c'],
          attributionBuilder: (_) {
            return const Text('© OpenStreetMap contributors');
          },
        ),
        MarkerLayerOptions(
          markers: List.generate(
            trafficAlertProvider.trafficAlertLength,
            (index) => Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(
                trafficAlertProvider.trafficAlert[index].lat,
                trafficAlertProvider.trafficAlert[index].lon,
              ),
              builder: (ctx) => const Icon(
                Icons.location_pin,
                size: 30,
                color: Colors.blueAccent,
              ),
            ),
          ),
          // [
          // Marker(
          //   width: 80.0,
          //   height: 80.0,
          //   point: LatLng(-12.8555212, 45.1053644),
          //   builder: (ctx) => const Icon(
          //     Icons.location_pin,
          //     size: 30,
          //     color: Colors.blueAccent,
          //   ),
          // ),
          // ],
        ),
      ],
    );
  }
}
