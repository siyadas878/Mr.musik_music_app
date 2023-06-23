import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mr.musik/dataBase/playList/EachPlayList.dart';
import 'package:Mr.musik/dataBase/playList/playlistFunctions.dart';
import 'package:Mr.musik/screens/PlayListScreens/playlistScreen.dart';
import 'package:Mr.musik/screens/splash.dart';
import 'package:Mr.musik/widgets/snakbar.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../dataBase/favourite/favFunction.dart';
import '../../functions/play.dart';
import '../../widgets/miniPlayer.dart';

class PlayListListScreen extends StatelessWidget {
  final int idx;
  final EachPlaylist currenPlaylistindex;
  PlayListListScreen(
      {super.key, required this.currenPlaylistindex, required this.idx});

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
          Stack(
            children: [
              Image.asset(
                'assets/images/lead.jpeg',
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                  left: 20,
                  top: 20,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new_sharp,
                          color: Color(0xFFF0ECC2)))),
              Positioned(
                  right: 20,
                  top: 20,
                  child: IconButton(
                      onPressed: () {
                        ListSongPopup(context);
                      },
                      icon: Icon(
                        Icons.add,
                        color: Color(0xFFF0ECC2),
                      )))
            ],
          ),
          Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFFF0ECC2),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  children: [
                    Text(
                      currenPlaylistindex.name,
                      style: GoogleFonts.oswald(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0xFF000000),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.play_arrow,
                            color: Color(0xFFF0ECC2),
                          )),
                    )
                  ],
                ),
              )),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: playListNotifier,
              builder: (context, value, child) {
                if(value[idx].container.isEmpty){
                          return Center(child: Text('Songs Empty' ,style: TextStyle(fontSize: 20, color: Colors.black)),);
                        }
                return ListView.builder(
                  padding: EdgeInsets.only(top: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        playAudio(value[idx].container, index);
                        showModalBottomSheet(
                            enableDrag: false,
                            context: context,
                            builder: (context) => MiniPLayer());
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => NowPlayingScreen(song: value[idx].container[index]),
                        //     ));
                      },
                      child: ListTile(
                          leading: QueryArtworkWidget(
                            size: 3000,
                            quality: 100,
                            artworkQuality: FilterQuality.high,
                            artworkBorder: BorderRadius.circular(7),
                            artworkFit: BoxFit.cover,
                            artworkWidth: MediaQuery.of(context).size.width * 0.15,
                            id: value[idx].container[index].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Image.asset(
                                'assets/images/lead.jpeg',
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width * 0.15,
                              ),
                            ),
                          ),
                          title: Text(
                              value[idx].container[index].songname ?? 'Unknown',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.oswald(
                                fontWeight: FontWeight.w500,
                              )),
                          subtitle: Text(
                              value[idx].container[index].artist ?? 'unknown',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.oswald()),
                          trailing: PopupMenuButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: Color(0xFF000000),
                            ),
                            color: Color(0xFFF0ECC2),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  value: 0,
                                  child: fav.value.contains(
                                          currenPlaylistindex.container[index])
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
                                    'Remove From Playlist',
                                    style: GoogleFonts.oswald(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                            ],
                            onSelected: (value) async {
                              if (value == 0) {
                                if (fav.value.contains(
                                    currenPlaylistindex.container[index])) {
                                  removeFromFav(
                                      currenPlaylistindex.container[index].id);
                                      SnackBarShowForFavoriteRemove(context);
                                } else {
                                  addToFav(
                                      currenPlaylistindex.container[index].id);
                                      SnackBarShowForFavorite(context);
                                }
                              } else if (value == 1) {
                                //  playlistRemoveDB();
                                playlistRemoveDB(
                                    currenPlaylistindex.container[index],
                                    currenPlaylistindex.name);
                                currenPlaylistindex.container.remove(
                                    currenPlaylistindex.container[index]);
                              }
                            },
                          )),
                    );
                  },
                  itemCount: value[idx].container.length,
                );
              },
            ),
          )
        ],
      ),
    ));
  }

  ListSongPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
            color: Color.fromARGB(255, 26, 35, 24),
            height: MediaQuery.of(context).size.height * 0.5,
            child: ValueListenableBuilder(
              valueListenable: playListNotifier,
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: allSongs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Card(
                        color: Color(0xFFF0ECC2),
                        child: ListTile(
                          trailing: IconButton(
                              onPressed: () {
                                if (!value[idx]
                                    .container
                                    .contains(allSongs[index])) {
                                  playlistAddDB(allSongs[index],
                                      currenPlaylistindex.name);
                                  value[idx].container.add(allSongs[index]);
                                } else {
                                  playlistRemoveDB(allSongs[index],
                                      currenPlaylistindex.name);
                                  value[idx].container.remove(allSongs[index]);
                                }
                              },
                              icon:
                                  value[idx].container.contains(allSongs[index])
                                      ? Icon(Icons.remove)
                                      : Icon(Icons.add)),
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
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width * 0.15,
                              ),
                            ),
                          ),
                          title: Text(allSongs[index].songname!,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.oswald(
                                fontWeight: FontWeight.w500,
                              )),
                          subtitle: Text(allSongs[index].artist ?? 'unknown',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.oswald()),
                        ),
                      ),
                    );
                  },
                );
              },
            ));
      },
    );
  }
}


