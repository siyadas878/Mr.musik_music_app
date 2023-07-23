import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../applications/nav_bloc/nav_bloc.dart';
import 'search_screen.dart';
import 'home.dart';
import 'playlist_screens/playlist_screen.dart';
import 'widgets/mini_player.dart';


class MyBottomNavigationBar extends StatelessWidget {
  MyBottomNavigationBar({Key? key});

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    PlayListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBloc, NavState>(
      builder: (context, state) {
        return Scaffold(
          body: _screens[state.navIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color.fromARGB(255, 135, 133, 105).withOpacity(.8),
            currentIndex: state.navIndex,
            onTap: (value) {
              BlocProvider.of<NavBloc>(context).add(NavEvent(index: value));
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, color: Color(0xFF000000)),
                activeIcon: Icon(Icons.home_outlined, color: Color(0xFFF0ECC2)),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search, color: Color(0xFF000000)),
                activeIcon: Icon(Icons.search, color: Color(0xFFF0ECC2)),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.playlist_play, color: Color(0xFF000000)),
                activeIcon: Icon(Icons.playlist_play, color: Color(0xFFF0ECC2)),
                label: '',
              ),
            ],
          ),
          bottomSheet: MiniPLayer(),
        );
      },
    );
  }
}
