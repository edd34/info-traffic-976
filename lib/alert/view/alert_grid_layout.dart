import 'package:flutter/material.dart';
import 'package:info_traffic_976/alert/models/alert_table.dart';
import 'package:info_traffic_976/alert/providers/add_alert_provider.dart';
import 'package:info_traffic_976/alert/providers/alert_providers.dart';
import 'package:provider/provider.dart';

class GridLayout extends StatelessWidget {
  const GridLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final alertProvider = Provider.of<AlertProvider>(context);
    final addAlertProvider = Provider.of<AddAlertProvider>(context);
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 2,
      // Generate 100 widgets that display their index in the List.
      children: List.generate(alertProvider.alertTableLength, (index) {
        AlertTable _alertTable = alertProvider.alertTable[index];

        return Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  addAlertProvider.setCurrentAlert(value: _alertTable);
                  print(addAlertProvider.selectedAlert);
                },
                child: Text(_alertTable.alertSubtype),
              )
            ],
          ),
        );
      }),
    );
  }
}
