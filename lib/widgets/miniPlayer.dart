import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mr.musik/functions/play.dart';
import 'package:Mr.musik/screens/home.dart';
import 'package:Mr.musik/screens/nowPlaying.dart';
import 'package:Mr.musik/widgets/playForMini.dart';
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
        return Container(
          height: 60,
          color: Colors.black.withOpacity(.1),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NowPlayingScreen(song: currentlyplaying,)));
                  },
                  child: Container(
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
                        style: GoogleFonts.oswald(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        player.getCurrentAudioArtist ,
                        style: GoogleFonts.oswald(),
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
        );
      },
    );
  }
}
