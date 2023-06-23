
import 'package:flutter/material.dart';
import 'package:Mr.musik/dataBase/favourite/favModel.dart';
import 'package:Mr.musik/dataBase/playList/playlistModel.dart';
import 'package:Mr.musik/screens/splash.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  
WidgetsFlutterBinding.ensureInitialized();
await Hive.initFlutter();
if (!Hive.isAdapterRegistered(FavourModelAdapter().typeId)) {
  Hive.registerAdapter(FavourModelAdapter());
}
if (!Hive.isAdapterRegistered(PlaylistClassAdapter().typeId)) {
Hive.registerAdapter(PlaylistClassAdapter());
}

runApp(MusicApp());  
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey
      ),
      home: SplashScreen(),
    );
  }
}