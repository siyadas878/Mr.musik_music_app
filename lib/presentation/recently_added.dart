import 'package:flutter/material.dart';
import 'package:Mr.musik/infrastructure/play.dart';
import 'package:Mr.musik/presentation/playlist_screens/playlist_adding.dart';
import 'package:Mr.musik/presentation/splash.dart';
import 'package:Mr.musik/presentation/widgets/top_card.dart';
import 'package:Mr.musik/presentation/widgets/snakbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../applications/favorite_bloc/favorite_bloc.dart';
import '../applications/recently_bloc/recently_bloc.dart';
import 'widgets/mini_player.dart';

class RecentlyScreen extends StatelessWidget {
  RecentlyScreen({super.key});

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
          TopCard(
            title: 'Recently Played',
            topImg: 'assets/images/recently.jpg',
          ),
          Expanded(
            child: BlocBuilder<RecentlyBloc, RecentlyState>(
              builder: (context, recentState) {
                if (recentState.recentList.isEmpty) {
                  return Center(
                    child: Text('Recently Played Empty',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  );
                }
                return ListView.builder(
                    padding: EdgeInsets.only(top: 8),
                    itemCount: recentState.recentList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 8, left: 8, bottom: 8),
                            child: InkWell(
                              onTap: () {
                                playAudio(recentState.recentList, index);
                                showModalBottomSheet(
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) => MiniPLayer());
                              },
                              child: ListTile(
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
                                                      .contains(allSongs[index])
                                                  ? Text(
                                                      'Remove From Favour',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    )
                                                  : Text(
                                                      'Add To Favour',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    )),
                                          PopupMenuItem(
                                              value: 1,
                                              child: Text(
                                                'Add To Playlist',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                        ],
                                        onSelected: (value) async {
                                          if (value == 0) {
                                            if (favstate.favorite
                                                .contains(allSongs[index])) {
                                              BlocProvider.of<FavoriteBloc>(context).add(AddToFav(favstate.favorite[index].id));
                                              SnackBarShowForFavoriteRemove(
                                                  context);
                                            } else {
                                              // BlocProvider.of<FavoriteBloc>(
                                              //         context)
                                              //     .add(FavoriteAddorRemove
                                              //         .remove(
                                              //             song:
                                              //                 recentState.recentList[
                                              //                     index]));
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
                                          }
                                        },
                                      );
                                    },
                                  ),
                                title: Text(recentState.recentList[index].songname!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    )),
                                subtitle: Text(
                                    recentState.recentList[index].artist ?? 'unknown',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle()),
                                leading: QueryArtworkWidget(
                                  size: 3000,
                                  quality: 100,
                                  artworkQuality: FilterQuality.high,
                                  artworkBorder: BorderRadius.circular(7),
                                  artworkFit: BoxFit.cover,
                                  artworkWidth:
                                      MediaQuery.of(context).size.width * 0.15,
                                  id: recentState.recentList[index].id,
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: Image.asset(
                                      'assets/images/lead.jpeg',
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    });
              },
            ),
          )
        ],
      ),
    ));
  }
}
