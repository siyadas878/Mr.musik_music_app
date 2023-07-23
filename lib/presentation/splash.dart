import 'dart:async';
import 'package:Mr.musik/applications/playlist_bloc/play_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:Mr.musik/infrastructure/fetch.dart';
import 'package:Mr.musik/domain/model.dart';
import 'package:Mr.musik/presentation/navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../applications/Mostly_bloc/most_bloc.dart';
import '../applications/favorite_bloc/favorite_bloc.dart';
import '../applications/recently_bloc/recently_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    wait(context);
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 51, 51, 48), Color.fromARGB(255, 40, 46, 41), Color.fromARGB(255, 51, 51, 48)],
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: ClipOval(child: Image.asset('assets/music logo design (2).png',
                height: 200,width: 200,))
              ),
            ]),
          )),
    );
  }

wait(context) async {
    await songfetch();
    BlocProvider.of<FavoriteBloc>(context).add(GetFavorite());
    BlocProvider.of<RecentlyBloc>(context).add(RecentFetch());
    BlocProvider.of<MostBloc>(context).add(MostPlayedFetch());
    BlocProvider.of<PlayListBloc>(context).add(PlaylistFetch());
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => MyBottomNavigationBar(),
        ),
      );
    });
  }
}

List<Songs> allSongs = [];
