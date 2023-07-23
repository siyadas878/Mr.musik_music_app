import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mr.musik/dataBase/playList/EachPlayList.dart';
import 'package:Mr.musik/presentation/splash.dart';
import 'package:Mr.musik/presentation/widgets/snakbar.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../applications/favorite_bloc/favorite_bloc.dart';
import '../../applications/playlist_bloc/play_list_bloc.dart';
import '../../infrastructure/play.dart';
import '../widgets/mini_player.dart';

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
            child: BlocBuilder<PlayListBloc, PlayListState>(
              builder: (context, playlistState) {
                if (playlistState.playlist[idx].container.isEmpty) {
                  return Center(
                    child: Text('Songs Empty',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.only(top: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        playAudio(playlistState.playlist[idx].container, index);
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
                          artworkWidth:
                              MediaQuery.of(context).size.width * 0.15,
                          id: playlistState.playlist[idx].container[index].id,
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
                            playlistState
                                    .playlist[idx].container[index].songname ??
                                'Unknown',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        subtitle: Text(
                            playlistState
                                    .playlist[idx].container[index].artist ??
                                'unknown',
                            overflow: TextOverflow.ellipsis),
                        trailing: BlocBuilder<FavoriteBloc, FavoriteState>(
                          builder: (context, favstate) {
                            return PopupMenuButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: Color(0xFF000000),
                              ),
                              color: Color(0xFFF0ECC2),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                    value: 0,
                                    child: favstate.favorite
                                            .contains(playlistState.playlist[idx].container[index])
                                        ? Text(
                                            'Remove From Favour',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        : Text(
                                            'Add To Favour',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                                PopupMenuItem(
                                    value: 1,
                                    child: Text(
                                      'Remove From PlayList',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
                              ],
                              onSelected: (value) async {
                                if (value == 0) {
                                  if (favstate.favorite
                                      .contains(playlistState.playlist[idx].container[index])) {
                                    BlocProvider.of<FavoriteBloc>(context).add(
                                        RemoveFromeFav(playlistState
                                            .playlist[idx]
                                            .container[index]
                                            .id));
                                    SnackBarShowForFavoriteRemove(context);
                                  } else {
                                    BlocProvider.of<FavoriteBloc>(context).add(
                                        AddToFav(playlistState.playlist[idx]
                                            .container[index].id));
                                    SnackBarShowForFavorite(context);
                                  }
                                } else if (value == 1) {
                                  BlocProvider.of<PlayListBloc>(context).add(
                                      PlaylistI.songRemoving(
                                          song: playlistState
                                              .playlist[idx].container[index],
                                          playlistIndex: index));
                                  playlistState.playlist[idx].container.remove(playlistState.playlist[idx].container[index]);
                                }
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                  itemCount: playlistState.playlist[idx].container.length,
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
            child: BlocBuilder<PlayListBloc, PlayListState>(
              builder: (context, playlistState) {
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
                                if (!playlistState.playlist[idx].container
                                    .contains(allSongs[index])) {
                                  BlocProvider.of<PlayListBloc>(context).add(
                                      PlaylistI.songAdding(
                                          song: allSongs[index],
                                          playlistIndex: index));
                                  // playlistAddDB(allSongs[index],
                                  //     currenPlaylistindex.name);
                                  playlistState.playlist[idx].container
                                      .add(allSongs[index]);
                                } else {
                                  BlocProvider.of<PlayListBloc>(context).add(
                                      PlaylistI.songRemoving(
                                          song: allSongs[index],
                                          playlistIndex: index));
                                  // playlistRemoveDB(allSongs[index],
                                  //     currenPlaylistindex.name);
                                  playlistState.playlist[idx].container
                                      .remove(allSongs[index]);
                                }
                              },
                              icon: playlistState.playlist[idx].container
                                      .contains(allSongs[index])
                                  ? Icon(Icons.remove)
                                  : Icon(Icons.add)),
                          leading: QueryArtworkWidget(
                            size: 3000,
                            quality: 100,
                            artworkQuality: FilterQuality.high,
                            artworkBorder: BorderRadius.circular(7),
                            artworkFit: BoxFit.cover,
                            artworkWidth:
                                MediaQuery.of(context).size.width * 0.15,
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
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          subtitle: Text(
                            allSongs[index].artist ?? 'unknown',
                            overflow: TextOverflow.ellipsis,
                          ),
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
