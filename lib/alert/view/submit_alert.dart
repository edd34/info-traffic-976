import 'package:flutter/material.dart';
import 'package:info_traffic_976/alert/providers/add_alert_provider.dart';
import 'package:info_traffic_976/alert/services/traffic_alert_api.dart';
import 'package:provider/provider.dart';

class SubmitAlert extends StatefulWidget {
  const SubmitAlert({Key? key}) : super(key: key);

  @override
  State<SubmitAlert> createState() => _SubmitAlertState();
}

class _SubmitAlertState extends State<SubmitAlert> {
  @override
  Widget build(BuildContext context) {
    final addAlertProvider = Provider.of<AddAlertProvider>(context);
    final position = addAlertProvider.currentPosition;
    final selectedAlert = addAlertProvider.selectedAlert;

    if (position.latitude == 0 && position.longitude == 0 ||
        selectedAlert.id == -1) {
      return Column(
        children: const [
          Spacer(),
          Text(
            'Position GPS pas initialisée',
            style: TextStyle(fontSize: 30),
          ),
          Spacer(),
          Text(
            'Alerte non sélectionnée',
            style: TextStyle(fontSize: 30),
          ),
          Spacer(flex: 2),
          Spacer(),
        ],
      );
    }

    return Column(
      children: [
        const Spacer(),
        const Text(
          'Position GPS :',
          style: TextStyle(fontSize: 30),
        ),
        Text(
          'Latitude : ${position.latitude}',
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          'Longitude : ${position.longitude}',
          style: const TextStyle(fontSize: 20),
        ),
        const Spacer(),
        const Text(
          'Alerte :',
          style: TextStyle(fontSize: 30),
        ),
        Text(
          'Type : ${selectedAlert.alertType}',
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          'Sous-Type : ${selectedAlert.alertSubtype}',
          style: const TextStyle(fontSize: 20),
        ),
        const Spacer(flex: 2),
        Row(
          children: [
            const Spacer(),
            ElevatedButton(
              onPressed: addAlertProvider.reset,
              child: const Text(
                'Effacer',
                style: TextStyle(fontSize: 25),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                await TrafficAlertAPIHelper.createTrafficAlert(
                  lon: position.longitude,
                  lat: position.latitude,
                  alertId: selectedAlert.id,
                );
              },
              child: const Text(
                'Valider',
                style: TextStyle(fontSize: 25),
              ),
            ),
            const Spacer(),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
