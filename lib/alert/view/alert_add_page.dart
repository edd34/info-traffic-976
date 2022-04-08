import 'package:flutter/material.dart';
import 'package:info_traffic_976/alert/view/alert_grid_layout.dart';
import 'package:info_traffic_976/alert/view/search_example.dart';

class AlertAddPage extends StatefulWidget {
  const AlertAddPage({Key? key}) : super(key: key);

  @override
  State<AlertAddPage> createState() => _AlertAddPageState();
}

class _AlertAddPageState extends State<AlertAddPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(icon: Icon(Icons.place)),
                Tab(icon: Icon(Icons.list_alt)),
                Tab(icon: Icon(Icons.check)),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            LocationAppExample(),
            Center(child: GridLayout()),
            Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );
  }
}
