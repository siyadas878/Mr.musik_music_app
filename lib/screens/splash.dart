import 'dart:async';
import 'package:flutter/material.dart';
import 'package:Mr.musik/functions/fetch.dart';
import 'package:Mr.musik/models/model.dart';
import 'package:Mr.musik/screens/navigationBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

List<Songs> allSongs = [];

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToHome();
  }

  @override
  Widget build(BuildContext context) {
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

  goToHome() async {
    FetchSongs fetchsong = FetchSongs();
    fetchsong.songfetch();
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => MyBottomNavigationBar())));
  }
}
