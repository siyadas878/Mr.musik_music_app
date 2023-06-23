import 'package:flutter/material.dart';
import '../widgets/miniPlayer.dart';
import 'Search.dart';
import 'home.dart';
import 'PlayListScreens/playlistScreen.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    PlayListScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 135, 133, 105).withOpacity(.8),
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined,color: Color(0xFF000000),),
            activeIcon: Icon(Icons.home_outlined, color:Color(0xFFF0ECC2)), 
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,color: Color(0xFF000000)),
            activeIcon: Icon(Icons.search, color:Color(0xFFF0ECC2)), 
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_play,color: Color(0xFF000000)),
             activeIcon: Icon(Icons.playlist_play, color:Color(0xFFF0ECC2)), 
            label: '',
          ),
        ],
      ),
      bottomSheet: MiniPLayer(),
    );
  }
}