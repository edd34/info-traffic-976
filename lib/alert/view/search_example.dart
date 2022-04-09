import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:info_traffic_976/alert/providers/add_alert_provider.dart';
import 'package:provider/provider.dart';

class LocationAppExample extends StatefulWidget {
  const LocationAppExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LocationAppExampleState();
}

class _LocationAppExampleState extends State<LocationAppExample> {
  ValueNotifier<GeoPoint?> notifier = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    final addAlertProvider =
        Provider.of<AddAlertProvider>(context, listen: false);
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            final p = await showSimplePickerLocation(
              context: context,
              isDismissible: true,
              title: 'location picker',
              textConfirmPicker: 'pick',
              initZoom: 15,
              // initPosition:
              //     GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
              radius: 8,
            );
            if (p != null) {
              addAlertProvider.setCurrentPosition(value: p);
              print(addAlertProvider.currentPosition);
            }
          },
          child: const Text('Outil sélection position'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Utiliser position GPS courante'),
        ),
        const Text(
          'Position GPS :',
          style: TextStyle(fontSize: 30),
        ),
        Text(
          'Latitude : ${addAlertProvider.currentPosition.latitude}',
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          'Longitude : ${addAlertProvider.currentPosition.longitude}',
          style: const TextStyle(fontSize: 20),
        ),
        const Spacer(),
      ],
    );
  }
}
