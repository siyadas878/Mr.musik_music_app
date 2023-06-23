import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mr.musik/models/model.dart';
import 'package:Mr.musik/screens/home.dart';
import 'package:Mr.musik/screens/PlayListScreens/playlistAdding.dart';
import 'package:Mr.musik/widgets/playPause.dart';
import 'package:Mr.musik/widgets/popup.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../dataBase/favourite/favFunction.dart';
import '../functions/lyrics.dart';
import '../functions/play.dart';

// Songs? currentlyplaying;

class NowPlayingScreen extends StatefulWidget {
  final Songs? song;
  NowPlayingScreen({super.key, this.song});

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

bool shuffleMode = false;
bool repeatMode = false;
int index = 0;

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  bool nextprevdone = true;
  bool ismostplayed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF555449), Color(0xFFF0ECC2), Color(0xFF555449)],
          begin: Alignment.topCenter,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 70,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new_sharp)),
                Spacer(),
                player.builderCurrent(
                  builder: (context, playing) {
                    int id = int.parse(playing.audio.audio.metas.id!);
                    currentlyplayingfinder(id);
                    return PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Color(0xFF000000),
                      ),
                      color: Color(0xFFF0ECC2),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            value: 0,
                            child: fav.value.contains(currentlyplaying)
                                ? Text(
                                    'Remove From Favour',
                                    style: GoogleFonts.oswald(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Text(
                                    'Add To Favour',
                                    style: GoogleFonts.oswald(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                        PopupMenuItem(
                            value: 1,
                            child: Text(
                              'Add To Playlist',
                              style: GoogleFonts.oswald(
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ],
                      onSelected: (value) async {
                        if (value == 0) {
                          if (fav.value.contains(currentlyplaying)) {
                            removeFromFav(fav.value[index].id);
                          } else {
                            addToFav(currentlyplaying!.id);
                          }
                        } else if (value == 1) {
                          // showPopupScreen(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PlayListAdding(addingsong: widget.song!),
                              ));
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          // CreaateAppBar(),
          const Divider(color: Color(0xFFF0ECC2)),
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Now Playing',
                style: GoogleFonts.oswald(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Color(0xFFF0ECC2)),
                  onPressed: () async {

                    String lyrics = await fetchlyrics(
                        player.getCurrentAudioTitle, player.getCurrentAudioArtist);
                    await Future.delayed(Duration(seconds: 3));

                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          color: Color.fromARGB(255, 26, 35, 24),
                          child: SingleChildScrollView(
                              child: Padding(
                            padding:  EdgeInsets.all(20.0),
                            child: Text(
                              lyrics,
                              style: GoogleFonts.oswald(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFF0ECC2),
                                  fontSize: 20),
                            ),
                          )),
                        );
                      },
                    );
                  },
                  child: Text(
                    'Lyrics',
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w500,
                    ),
                  )),

              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                height: 300,
                width: 250,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  color: const Color(0xFFF0ECC2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25)),
                        child: PlayerBuilder.current(
                          player: player,
                          builder: (context, playing) {
                            int id = int.parse(playing.audio.audio.metas.id!);
                            currentlyplayingfinder(id);
                            return QueryArtworkWidget(
                              size: 3000,
                              quality: 100,
                              keepOldArtwork: true,
                              artworkQuality: FilterQuality.high,
                              artworkBorder: BorderRadius.circular(0),
                              artworkFit: BoxFit.cover,
                              artworkWidth: double.infinity,
                              artworkHeight: 210,
                              id: int.parse(playing.audio.audio.metas.id!),
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: Image.asset(
                                  'assets/images/lead.jpeg',
                                  width: double.infinity,
                                  height: 210,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: PlayerBuilder.current(
                            player: player,
                            builder: (context, playing) {
                              return Column(
                                children: [
                                  Text(
                                    player.getCurrentAudioTitle,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.oswald(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(player.getCurrentAudioArtist,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.oswald(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black)),
                                ],
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: player.builderRealtimePlayingInfos(
                      builder: (context, Infos) {
                    Duration currentposition = Infos.currentPosition;
                    Duration totalduration = Infos.duration;

                    return ProgressBar(
                      progress: currentposition,
                      total: totalduration,
                      progressBarColor: Color(0xFF000000),
                      thumbColor: Color(0xFFF0ECC2),
                      onSeek: (duration) {
                        player.seek(duration);
                      },
                    );
                  })),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          shuffleMode = !shuffleMode;
                        });
                        player.toggleShuffle();
                      },
                      icon: Icon(Icons.shuffle,
                          color:
                              shuffleMode ? Color(0xFFF0ECC2) : Colors.black)),
                  SizedBox(width: 20),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xFF000000),
                    child: IconButton(
                        onPressed: () async {
                          if (nextprevdone) {
                            nextprevdone = false;
                            await player.previous();
                            nextprevdone = true;
                          }
                        },
                        icon: Icon(
                          Icons.skip_previous,
                          color: Color(0xFFF0ECC2),
                        )),
                  ),
                  SizedBox(width: 20),
                  PlayPauseButton(),
                  SizedBox(width: 20),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xFF000000),
                    child: IconButton(
                        onPressed: () async {
                          if (nextprevdone) {
                            nextprevdone = false;
                            await player.next();
                            nextprevdone = true;
                          }
                        },
                        icon: Icon(
                          Icons.skip_next,
                          color: Color(0xFFF0ECC2),
                        )),
                  ),
                  SizedBox(width: 20),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          repeatMode = !repeatMode;
                        });
                        player.setLoopMode(LoopMode.single);
                      },
                      icon: Icon(
                        Icons.repeat,
                        color: repeatMode ? Color(0xFFF0ECC2) : Colors.black,
                      ))
                ],
              )
            ],
          )
        ],
      ),
    ));
  }
}

Widget CreaateAppBar() {
  return AppBar(
    toolbarHeight: 40,
    elevation: 0,
    backgroundColor: Colors.transparent,
    actions: [
      SongPopup(
        icon: Icon(Icons.more_vert),
      )
    ],
  );
}
