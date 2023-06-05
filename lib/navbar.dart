import 'package:flutter/material.dart';
import 'package:jadwal_sholat/page/conversionpage.dart';
import 'package:jadwal_sholat/page/homepage.dart';
import 'package:jadwal_sholat/page/search.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;
  List pages = [
    const Homepage(),
    const Searchpage(),
    const CurrencyConversionPage(),
  ];

  void _onTap(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'Jadwal Sholat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Konversi',
          ),
        ],
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedItemColor: Colors.cyan,
        currentIndex: _selectedIndex,
        onTap: _onTap,
      ),
    );
  }
}
