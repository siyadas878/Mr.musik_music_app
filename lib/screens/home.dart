import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mr.musik/functions/play.dart';
import 'package:Mr.musik/screens/nowPlaying.dart';
import 'package:Mr.musik/screens/PlayListScreens/playlistAdding.dart';
import 'package:Mr.musik/screens/settings/settings.dart';
import 'package:Mr.musik/screens/splash.dart';
import 'package:Mr.musik/widgets/cards.dart';
import 'package:Mr.musik/widgets/snakbar.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../dataBase/favourite/favFunction.dart';
import '../widgets/miniPlayer.dart';
import 'allSong.dart';
import 'favourite.dart';
import 'most.dart';
import 'recently.dart';

AssetsAudioPlayer player = AssetsAudioPlayer();

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget CreaateAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 40,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          Icon(Icons.music_note),
          Text(
            'Library',
            style: GoogleFonts.oswald(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => SettingsScreen(),
                  ));
            },
            icon: Icon(
              Icons.settings,
              color: Color(0xFF000000),
            ))
      ],
    );
  }

  List<String> img = [
    'assets/images/all.jpg',
    'assets/images/favourite.jpg',
    'assets/images/recently.jpg',
    'assets/images/most.jpg',
  ];

  List<String> texts = [
    'All\nSongs',
    'My\nFavourite',
    'Recently\nPlayed',
    'Most\nPlayed',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF555449), Color(0xFFF0ECC2), Color(0xFF555449)],
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CreaateAppBar(context),
          const Divider(
            color: Color(0xFFF0ECC2),
          ),
          SizedBox(
           height: 240,
            child: ListView.builder(
              itemCount: img.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllSongScreen(),
                              ),
                            );
                          } else if (index == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FavouriteScreen(),
                              ),
                            );
                          } else if (index == 2) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecentlyScreen(),
                              ),
                            );
                          } else if (index == 3) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MostScreen(),
                              ),
                            );
                          }
                        },
                        child:
                            CardList(images: img[index], texts: texts[index]))
                  ],
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
          const Divider(color: Color(0xFFF0ECC2)),
          
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(top: 8),
                itemCount: allSongs.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              right: 8, left: 8, bottom: 8),
                          child: InkWell(
                              onTap: () {
                                playAudio(allSongs, index);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NowPlayingScreen(song: allSongs[index]),
                                    ));
                              },
                              child: ListTile(
                                trailing: PopupMenuButton(
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: Color(0xFF000000),
                                  ),
                                  color: Color(0xFFF0ECC2),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                        value: 0,
                                        child: fav.value
                                                .contains(allSongs[index])
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
                                      if (fav.value.contains(allSongs[index])) {
                                        removeFromFav(allSongs[index].id);
                                        SnackBarShowForFavoriteRemove(context);
                                      } else {
                                        addToFav(allSongs[index].id);
                                        SnackBarShowForFavorite(context);
                                      }
                                    } else if (value == 1) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PlayListAdding(
                                                    addingsong:
                                                        allSongs[index]),
                                          ));
                                      // addToPlay(allSongs[index].id,'my');
                                    }
                                  },
                                ),
                                leading: QueryArtworkWidget(
                                  size: 3000,
                                  quality: 100,
                                  artworkQuality: FilterQuality.high,
                                  artworkBorder: BorderRadius.circular(7),
                                  artworkFit: BoxFit.cover,
                                  artworkWidth: MediaQuery.of(context).size.width * 0.15,
                                  id: allSongs[index].id,
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: Image.asset(
                                      'assets/images/lead.jpeg',
                                      width: MediaQuery.of(context).size.width * 0.15,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                               
                                title: Text(allSongs[index].songname!,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.oswald(
                                      fontWeight: FontWeight.w500,
                                    )),
                                subtitle: Text(
                                    allSongs[index].artist ?? 'unknown',
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.oswald()),
                              )))
                    ],
                  );
                }),
          ),
          // MiniPLayer()
        ]),
      ),
    );
  }
}
