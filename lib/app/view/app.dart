// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:info_traffic_976/alert/alert.dart';
import 'package:info_traffic_976/alert/providers/alert_providers.dart';
import 'package:info_traffic_976/alert/providers/position_provider.dart';
import 'package:info_traffic_976/alert/providers/traffic_alert.dart';
import 'package:info_traffic_976/alert/services/alert_api.dart';
import 'package:info_traffic_976/alert/services/traffic_alert_api.dart';
import 'package:info_traffic_976/map/map.dart';
import 'package:info_traffic_976/map/view/map_page_osm.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AlertProvider()),
        ChangeNotifierProvider(create: (context) => TrafficAlertProvider()),
        ChangeNotifierProvider(create: (context) => LocalisationProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color(0xFF13B9FF),
          ),
        ),
        home: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  String _title = 'Carte routière';

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static const List<Widget> _widgetOptions = <Widget>[
    MainExample(),
    AlertAddPage(),
  ];

  Future refreshAlert(BuildContext context) async {
    final alertProvider = Provider.of<AlertProvider>(context, listen: false);
    final trafficAlertProvider =
        Provider.of<TrafficAlertProvider>(context, listen: false);
    var res1 = await AlertAPIHelper.getAlertTable();
    var res2 = await TrafficAlertAPIHelper.getTrafficAlert();
    print(res1.data);
    print(res2.data);
    alertProvider.setAlertTable(res1.data);
    trafficAlertProvider.setTrafficAlert(res2.data);
    print(trafficAlertProvider.trafficAlert);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          _title = 'Carte routière';
          break;
        case 1:
          _title = 'Ajouter alerte';
          break;
        default:
          _title = 'Info Traffic 976';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              //header of drawer
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              //menu item of Drawer
              leading: Icon(Icons.home),
              title: Text('Accueil'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Mon profil'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Paramètres'),
            ),
            ListTile(
                onTap: () {
                  if (scaffoldKey.currentState!.isDrawerOpen) {
                    //check if drawer is open
                    Navigator.pop(context); //context of drawer is different
                  }
                },
                leading: Icon(Icons.info),
                title: Text("À propos"))
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 10,
        //shadow
        titleSpacing: 10,
        //space between leading icon and title
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            if (!scaffoldKey.currentState!.isDrawerOpen) {
              //check if drawer is closed
              scaffoldKey.currentState?.openDrawer(); //open drawer
            }
          },
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       refreshAlert(context);
        //     },
        //     icon: const Icon(Icons.refresh),
        //   ),
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(Icons.sort),
        //   ),
        // ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Ajouter',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
