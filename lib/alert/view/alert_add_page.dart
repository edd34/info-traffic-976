import 'package:flutter/material.dart';
import 'package:info_traffic_976/alert/view/alert_grid_layout.dart';
import 'package:info_traffic_976/alert/view/search_example.dart';

class AlertAddPage extends StatelessWidget {
  const AlertAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.place)),
                Tab(icon: Icon(Icons.list_alt)),
                Tab(icon: Icon(Icons.check)),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            LocationAppExample(),
            Center(child: GridLayout()),
            Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );
  }
}
