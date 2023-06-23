import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:Mr.musik/screens/home.dart';

class PlayPauseButton extends StatefulWidget {
  @override
  _PlayPauseButtonState createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> {

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
       radius: 35,
       backgroundColor: Color(0xFF000000),
      child: PlayerBuilder.isPlaying(
        player: player,
        builder: (context, isPlaying) {
          return IconButton(
          icon: Icon(
            isPlaying ? Icons.pause:Icons.play_arrow,color: Color(0xFFF0ECC2),
          ),
          onPressed: () {
            player.playOrPause();
          },
        );
        },
      ),
    );
  }
}
