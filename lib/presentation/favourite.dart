import 'package:flutter/material.dart';
import 'package:Mr.musik/presentation/playlist_screens/playlist_adding.dart';
import 'package:Mr.musik/presentation/widgets/top_card.dart';
import 'package:Mr.musik/presentation/widgets/mini_player.dart';
import 'package:Mr.musik/presentation/widgets/snakbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../applications/favorite_bloc/favorite_bloc.dart';
import '../infrastructure/play.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({super.key});

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
            title: 'My Favourite',
            topImg: 'assets/images/favourite.jpg',
          ),
          Expanded(
            child: BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, favstate) {
                if (favstate.favorite.isEmpty) {
                  return Center(
                    child: Text('Favorite Empty',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  );
                }
                return ListView.builder(
                    padding: EdgeInsets.only(top: 8),
                    itemCount: favstate.favorite.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  right: 8, left: 8, bottom: 8),
                              child: InkWell(
                                  onTap: () {
                                    playAudio(favstate.favorite, index);

                                    showModalBottomSheet(
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) => MiniPLayer());
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
                                            child: Text(
                                              'Remove From Favour',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
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
                                      onSelected: (value) {
                                        if (value == 0) {
                                          BlocProvider.of<FavoriteBloc>(context)
                                              .add(RemoveFromeFav(
                                                  favstate.favorite[index].id));
                                          SnackBarShowForFavoriteRemove(
                                              context);
                                        } else if (value == 1) {
                                          // showPopupScreen(context);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PlayListAdding(
                                                        addingsong: favstate
                                                            .favorite[index]),
                                              ));
                                        }
                                      },
                                    ),
                                    leading: QueryArtworkWidget(
                                      size: 3000,
                                      quality: 100,
                                      artworkQuality: FilterQuality.high,
                                      artworkBorder: BorderRadius.circular(7),
                                      artworkFit: BoxFit.cover,
                                      artworkWidth:
                                          MediaQuery.of(context).size.width *
                                              0.15,
                                      id: favstate.favorite[index].id,
                                      type: ArtworkType.AUDIO,
                                      nullArtworkWidget: ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child: Image.asset(
                                          'assets/images/lead.jpeg',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    title:
                                        Text(favstate.favorite[index].songname!,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            )),
                                    subtitle: Text(
                                        favstate.favorite[index].artist ??
                                            'unknown',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle()),
                                  ))),
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
