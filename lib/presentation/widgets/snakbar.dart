 import 'package:flutter/material.dart';

SnackBarShowForPlaylist(ctx){
  ScaffoldMessenger.of(ctx).showSnackBar( const SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromARGB(255, 26, 35, 24),
      duration: Duration(seconds: 1),
      margin: EdgeInsets.all(10),
      content: Text('Song already exists',style: TextStyle(color: Color(0xFFF0ECC2)),),),);
}

SnackBarShowForPlaylistAdd(ctx){
  ScaffoldMessenger.of(ctx).showSnackBar( const SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromARGB(255, 26, 35, 24),
      duration: Duration(seconds: 1),
      margin: EdgeInsets.all(10),
      content: Text('Song added to playlist',style: TextStyle(color: Color(0xFFF0ECC2)),),),);
}

SnackBarShowForFavorite(ctx){
  ScaffoldMessenger.of(ctx).showSnackBar( const SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromARGB(255, 26, 35, 24),
      duration: Duration(seconds: 1),
      margin: EdgeInsets.all(10),
      content: Text('Song added to favorite',style: TextStyle(color: Color(0xFFF0ECC2)),),),);
}

SnackBarShowForFavoriteRemove(ctx){
  ScaffoldMessenger.of(ctx).showSnackBar( const SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromARGB(255, 26, 35, 24),
      duration: Duration(seconds: 1),
      margin: EdgeInsets.all(10),
      content: Text('Song removed from favorite',style: TextStyle(color: Color(0xFFF0ECC2)),),),);
}


