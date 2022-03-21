// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:info_traffic_976/alert/alert.dart';
import 'package:info_traffic_976/l10n/l10n.dart';
import 'package:info_traffic_976/map/map.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MyStatefulWidget(),
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
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static const List<Widget> _widgetOptions = <Widget>[
    MapPage(),
    AlertAddPage(),
  ];

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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.supervised_user_circle),
          )
        ],
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
