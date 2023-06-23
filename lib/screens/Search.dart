import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mr.musik/models/model.dart';
import 'package:Mr.musik/screens/navigationBar.dart';
import 'package:Mr.musik/screens/splash.dart';
import 'package:Mr.musik/widgets/snakbar.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../dataBase/favourite/favFunction.dart';
import '../functions/play.dart';
import '../widgets/miniPlayer.dart';
import 'PlayListScreens/playlistAdding.dart';
import 'nowPlaying.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final FocusNode _focusNode = FocusNode();
  ValueNotifier<List<Songs>> data = ValueNotifier([]);
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {
      _focusNode.unfocus();
    },
      child: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF555449), Color(0xFFF0ECC2), Color(0xFF555449)],
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
                                  contentPadding: const EdgeInsets.only(top: 10),
                                  prefixIcon: const Icon(Icons.search),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        clear();
                                        setState(() {
                                          showAllSongs();
                                        });
                                      },
                                      icon: Icon(Icons.clear)),
                                  hintStyle: const TextStyle(fontSize: 20),
                                  hintText: 'Search',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: const Color(0xFFF0ECC2)),
                              onChanged: (value) {
                                search(value, data);
                              },
                            ),
                          ),
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: data,
                        builder: (context, value, child) {
                          return Expanded(
                              child: searchController.text.isEmpty ||
                                      searchController.text.trim().isEmpty
                                  ? showAllSongs()
                                  : data.value.isEmpty
                                      ? searchisempty()
                                      : searchfound(context, data));
                        },
                      ),
                      // MiniPLayer()
                    ],
                  )),
      ),
    );
  }

  search(String querry, ValueNotifier data) {
    data.value = allSongs
        .where((element) => element.songname!
            .toLowerCase()
            .contains(querry.toLowerCase().trim()))
        .toList();
  }

  clear() {
    searchController.clear();
  }

  Widget CreaateAppBar(BuildContext context) {
    return AppBar(
      title: InkWell(
      onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyBottomNavigationBar(),)),
      child: Text(
        '< My Search',
        style:
            GoogleFonts.oswald(fontWeight: FontWeight.bold, color: Colors.black),
      ),
    ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      toolbarHeight: 40.0,
    );
  }
}

Widget searchfound(context, ValueNotifier data) {
  return ListView.builder(
    padding: EdgeInsets.only(top: 1),
      itemCount: data.value.length,
      itemBuilder: (context, index) => InkWell(
            onTap: () {
              Songs selectedsong = data.value[index];
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
                id: data.value[index].id,
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
              title: Text(data.value[index].songname!,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.w500,
                  )),
              subtitle: Text(data.value[index].artist ?? 'unknown',
                  overflow: TextOverflow.ellipsis, style: GoogleFonts.oswald()),
                  trailing: PopupMenuButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: Color(0xFF000000),
                        ),
                        color: Color(0xFFF0ECC2),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              value: 0,
                              child: fav.value.contains(data.value[index])
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
                            if (fav.value.contains(data.value[index])) {
                              removeFromFav(fav.value[index].id);
                            } else {
                              addToFav(data.value[index].id);
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
                      trailing: PopupMenuButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: Color(0xFF000000),
                        ),
                        color: Color(0xFFF0ECC2),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              value: 0,
                              child: fav.value.contains(allSongs[index])
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
                              removeFromFav(fav.value[index].id);
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
