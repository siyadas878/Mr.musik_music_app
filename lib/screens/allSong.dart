import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mr.musik/dataBase/favourite/favFunction.dart';
import 'package:Mr.musik/functions/play.dart';
import 'package:Mr.musik/models/model.dart';
import 'package:Mr.musik/screens/PlayListScreens/playlistAdding.dart';
import 'package:Mr.musik/screens/splash.dart';
import 'package:Mr.musik/widgets/TopCard.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../widgets/miniPlayer.dart';
import '../widgets/snakbar.dart';

List<Songs> songss = [];

class AllSongScreen extends StatefulWidget {
  AllSongScreen({super.key});

  @override
  State<AllSongScreen> createState() => _AllSongScreenState();
}

class _AllSongScreenState extends State<AllSongScreen> {
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
              TopCard(title: 'All Songs', topImg: 'assets/images/all.jpg'),
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
                                // child: MyListView(items: itemss[index]),
                                child: InkWell(
                                    onTap: () {
                                       playAudio(allSongs, index);
      
                                     showModalBottomSheet(
                                enableDrag: false,
                                context: context,
                                builder: (context) =>  MiniPLayer());
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
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    )
                                                  : Text(
                                                      'Add To Favour',
                                                      style: GoogleFonts.oswald(
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                            if (fav.value
                                                .contains(allSongs[index])) {
                                              removeFromFav(
                                                  fav.value[index].id);
                                              SnackBarShowForFavoriteRemove(
                                                  context);
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
                                          borderRadius:
                                              BorderRadius.circular(7),
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
                                      subtitle: Text(
                                          allSongs[index].artist ?? 'unknown',
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.oswald()),
                                    )))
                          ],
                        );
                      }))
            ],
          )),
    );
  }
}
