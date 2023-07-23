import 'package:flutter/material.dart';
import 'package:Mr.musik/infrastructure/play.dart';
import 'package:Mr.musik/presentation/playlist_screens/playlist_adding.dart';
import 'package:Mr.musik/presentation/splash.dart';
import 'package:Mr.musik/presentation/widgets/top_card.dart';
import 'package:Mr.musik/presentation/widgets/snakbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../applications/Mostly_bloc/most_bloc.dart';
import '../applications/favorite_bloc/favorite_bloc.dart';
import 'widgets/mini_player.dart';

class MostScreen extends StatelessWidget {
  MostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF555449),
                  Color(0xFFF0ECC2),
                  Color(0xFF555449)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
              ),
            ),
            child: Column(children: [
              TopCard(
                title: 'Most Played',
                topImg: 'assets/images/most.jpg',
              ),
              Expanded(
                  child: BlocBuilder<MostBloc, MostState>(
                builder: (context, mostState) {
                  if (mostState.mostPlayedList.isEmpty) {
                    return Center(
                      child: Text('Mostly Played Empty',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                    );
                  }
                  return ListView.builder(
                      padding: EdgeInsets.only(top: 8),
                      itemCount: mostState.mostPlayedList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 8, left: 8, bottom: 8),
                              child: InkWell(
                                onTap: () {
                                  playAudio(mostState.mostPlayedList, index);
                                  showModalBottomSheet(
                                      enableDrag: false,
                                      context: context,
                                      builder: (context) => MiniPLayer());
                                },
                                child: ListTile(
                                  trailing:
                                      BlocBuilder<FavoriteBloc, FavoriteState>(
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
                                              BlocProvider.of<FavoriteBloc>(
                                                      context)
                                                  .add(RemoveFromeFav(mostState.mostPlayedList[index].id));
                                              SnackBarShowForFavoriteRemove(
                                                  context);
                                            } else {
                                              BlocProvider.of<FavoriteBloc>(
                                                      context).add(AddToFav(mostState.mostPlayedList[index].id));
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
                                  title: Text(
                                      mostState.mostPlayedList[index].songname!,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      )),
                                  subtitle: Text(
                                      mostState.mostPlayedList[index].artist ??
                                          'unknown',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle()),
                                  leading: QueryArtworkWidget(
                                    size: 3000,
                                    quality: 100,
                                    artworkQuality: FilterQuality.high,
                                    artworkBorder: BorderRadius.circular(7),
                                    artworkFit: BoxFit.cover,
                                    artworkWidth:
                                        MediaQuery.of(context).size.width *
                                            0.15,
                                    id: mostState.mostPlayedList[index].id,
                                    type: ArtworkType.AUDIO,
                                    nullArtworkWidget: ClipRRect(
                                      borderRadius: BorderRadius.circular(7),
                                      child: Image.asset(
                                        'assets/images/lead.jpeg',
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width *
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
              ))
            ])));
  }
}
