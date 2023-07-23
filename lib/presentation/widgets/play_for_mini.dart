import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:Mr.musik/presentation/home.dart';

class PlayForMini extends StatefulWidget {
  @override
  _PlayPauseButtonState createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayForMini> {


  @override
  Widget build(BuildContext context) {
    return PlayerBuilder.isPlaying(
        player: player,
        builder: (context, isPlaying) {
          return IconButton(
          icon: Icon(
            isPlaying ? Icons.pause:Icons.play_arrow,color: Colors.black,
          ),
          // onPressed: togglePlayPause  
          onPressed: () {
            player.playOrPause();
          },
        );
        },
      );
  }
}
