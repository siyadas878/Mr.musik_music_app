import 'package:flutter/material.dart';
import 'package:Mr.musik/domain/model.dart';
import 'package:Mr.musik/presentation/splash.dart';
import 'package:Mr.musik/presentation/widgets/snakbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../applications/favorite_bloc/favorite_bloc.dart';
import '../applications/search_bloc/search_bloc.dart';
import '../infrastructure/play.dart';
import 'playlist_screens/playlist_adding.dart';
import 'now_playing.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final FocusNode _focusNode = FocusNode();

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
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
            child: allSongs.isEmpty
                ? const Center(
                    child: Text(
                      'No songs found',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  )
                : Column(
                    children: [
                      CreaateAppBar(context),
                      const Divider(color: Color(0xFFF0ECC2)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: TextField(
                              focusNode: _focusNode,
                              controller: searchController,
                              style: const TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(top: 10),
                                  prefixIcon: const Icon(Icons.search),
                                  // suffixIcon: IconButton(
                                  //     onPressed: () {
                                  //       clear();
                                  //       showAllSongs();
                                  //     },
                                  //     icon: Icon(Icons.clear)),
                                  hintStyle: const TextStyle(fontSize: 20),
                                  hintText: 'Search',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: const Color(0xFFF0ECC2)),
                              onChanged: (value) {
                                BlocProvider.of<SearchBloc>(context)
                                          .add(SearchEvent(querry: value));
                              },
                            ),
                          ),
                        ),
                      ),
                      BlocBuilder<SearchBloc, SearchState>(
                        builder: (context, state) {
                          return Expanded(
                              child: searchController.text.isEmpty ||
                                      searchController.text.trim().isEmpty
                                  ? showAllSongs()
                                  : state.searchdata.isEmpty
                                      ? searchisempty()
                                      : searchfound(context, state));
                        },
                      ),
                      // MiniPLayer()
                    ],
                  )),
      ),
    );
  }

  clear() {
    searchController.clear();
  }

  Widget CreaateAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'My Search',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      toolbarHeight: 40.0,
    );
  }
}

Widget searchfound(context,SearchState searchState) {
  return ListView.builder(
      padding: EdgeInsets.only(top: 1),
      itemCount: searchState.searchdata.length,
      itemBuilder: (context, index) => InkWell(
            onTap: () {
              Songs selectedsong = searchState.searchdata[index];
              int songindex = 0;
              for (int i = 0; i < allSongs.length; i++) {
                if (selectedsong == allSongs[i]) {
                  songindex = i;
                }
              }
              playAudio(allSongs, songindex);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NowPlayingScreen(),
              ));
            },
            child: ListTile(
              leading: QueryArtworkWidget(
                size: 3000,
                quality: 100,
                artworkQuality: FilterQuality.high,
                artworkBorder: BorderRadius.circular(7),
                artworkFit: BoxFit.cover,
                artworkWidth: MediaQuery.of(context).size.width * 0.15,
                id: searchState.searchdata[index].id,
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
              title: Text(searchState.searchdata[index].songname!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  )),
              subtitle: Text(searchState.searchdata[index].artist ?? 'unknown',
                  overflow: TextOverflow.ellipsis, style: TextStyle()),
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
                          child: favstate.favorite.contains(allSongs[index])
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
                            'Add To Playlist',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ],
                    onSelected: (value) async {
                      if (value == 0) {
                        if (favstate.favorite.contains(allSongs[index])) {
                          BlocProvider.of<FavoriteBloc>(context)
                              .add(RemoveFromeFav(allSongs[index].id));
                          SnackBarShowForFavoriteRemove(context);
                        } else {
                          BlocProvider.of<FavoriteBloc>(context)
                              .add(AddToFav(allSongs[index].id));
                          SnackBarShowForFavorite(context);
                        }
                      } else if (value == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PlayListAdding(addingsong: allSongs[index]),
                            ));
                      }
                    },
                  );
                },
              ),
            ),
          ));
}

showAllSongs() {
  return ListView.builder(
      padding: EdgeInsets.only(top: 8),
      itemCount: allSongs.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                child: InkWell(
                    onTap: () {
                      playAudio(allSongs, index);
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
                                  BlocProvider.of<FavoriteBloc>(context)
                                      .add(RemoveFromeFav(allSongs[index].id));
                                  SnackBarShowForFavoriteRemove(context);
                                } else {
                                  BlocProvider.of<FavoriteBloc>(context)
                                      .add(AddToFav(allSongs[index].id));
                                  SnackBarShowForFavorite(context);
                                }
                              } else if (value == 1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlayListAdding(
                                          addingsong: allSongs[index]),
                                    ));
                              }
                            },
                          );
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
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width * 0.15,
                          ),
                        ),
                      ),
                      title: Text(allSongs[index].songname!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          )),
                      subtitle: Text(allSongs[index].artist ?? 'unknown',
                          overflow: TextOverflow.ellipsis, style: TextStyle()),
                    )))
          ],
        );
      });
}

searchisempty() {
  return SizedBox(
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'File not found',
            style: TextStyle(fontSize: 20, color: Colors.black),
          )
        ],
      ),
    ),
  );
}
