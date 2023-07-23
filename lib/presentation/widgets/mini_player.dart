import 'package:Mr.musik/applications/Mostly_bloc/most_bloc.dart';
import 'package:Mr.musik/applications/recently_bloc/recently_bloc.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:Mr.musik/infrastructure/play.dart';
import 'package:Mr.musik/presentation/home.dart';
import 'package:Mr.musik/presentation/now_playing.dart';
import 'package:Mr.musik/presentation/widgets/play_for_mini.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPLayer extends StatelessWidget {
  const MiniPLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return player.builderCurrent(
      builder: (context, playing) {
        int id = int.parse(playing.audio.audio.metas.id!);
        currentlyplayingfinder(id);
        print(currentlyplayingfinder(id));
        BlocProvider.of<MostBloc>(context).add(MostPlayedAdd(songid: id));
        BlocProvider.of<RecentlyBloc>(context).add(RecentAdd(songid: id));
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NowPlayingScreen(
                          song: currentlyplaying,
                        )));
          },
          child: Container(
            height: 60,
            color: Colors.black.withOpacity(.1),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    child: QueryArtworkWidget(
                      size: 3000,
                      quality: 100,
                      artworkQuality: FilterQuality.high,
                      artworkBorder: BorderRadius.circular(7),
                      artworkFit: BoxFit.cover,
                      artworkWidth: 50,
                      id: int.parse(playing.audio.audio.metas.id!),
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Image.asset(
                          'assets/images/lead.jpeg',
                          fit: BoxFit.cover,
                          width: 50,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          player.getCurrentAudioTitle,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          player.getCurrentAudioArtist,
                          style: TextStyle(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.skip_previous),
                    onPressed: () {
                      player.previous();
                    },
                  ),
                  PlayForMini(),
                  IconButton(
                    icon: Icon(Icons.skip_next),
                    onPressed: () {
                      player.next();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
