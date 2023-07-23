import 'package:Mr.musik/applications/Mostly_bloc/most_bloc.dart';
import 'package:Mr.musik/applications/playlist_bloc/play_list_bloc.dart';
import 'package:Mr.musik/applications/search_bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:Mr.musik/dataBase/favourite/fav_model.dart';
import 'package:Mr.musik/dataBase/playList/playlistModel.dart';
import 'package:Mr.musik/presentation/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'applications/favorite_bloc/favorite_bloc.dart';
import 'applications/nav_bloc/nav_bloc.dart';
import 'applications/recently_bloc/recently_bloc.dart';

void main() async {
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavBloc>(
          create: (context) => NavBloc(),
        ),
        BlocProvider<FavoriteBloc>(
          create: (context) => FavoriteBloc(),
        ),
        BlocProvider<RecentlyBloc>(
          create: (context) => RecentlyBloc(),
        ),
        BlocProvider<MostBloc>(
          create: (context) => MostBloc(),
        ),
        BlocProvider<PlayListBloc>(
          create: (context) => PlayListBloc(),
        ),
         BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
      ],
      child: MaterialApp(
        // darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: GoogleFonts.montserrat().fontFamily,
            primarySwatch: Colors.grey),
        home: SplashScreen(),
      ),
    );
  }
}
