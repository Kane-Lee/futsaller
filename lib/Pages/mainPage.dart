import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Screens/homeScreen.dart';
import '../Screens/playScreen.dart';
import '../Screens/recordsScreen.dart';
import '../Screens/teamScreen.dart';
import '../Screens/SettingScreen.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTabbed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    RecordsScreen(),
    PlayScreen(),
    TeamScreen(),
    SettingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.blue,
          items: [
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.home), label: 'home'),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.chartBar), label: 'Records'),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.futbol), label: 'Play'),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.users), label: 'Team'),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.ellipsisH), label: 'Setting'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTabbed,
        ));
  }
}
