import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:info_traffic_976/alert/providers/position_provider.dart';
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
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            final localisationProvider =
                Provider.of<LocalisationProvider>(context, listen: false);
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
              localisationProvider.setCurrentPosition(value: p);
            }
          },
          child: const Text('Outil sélection position'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Utiliser position GPS courante'),
        ),
      ],
    );
  }
}
