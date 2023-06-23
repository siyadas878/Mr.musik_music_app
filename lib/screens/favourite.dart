import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mr.musik/dataBase/favourite/favFunction.dart';
import 'package:Mr.musik/screens/PlayListScreens/playlistAdding.dart';
import 'package:Mr.musik/widgets/TopCard.dart';
import 'package:Mr.musik/widgets/miniPlayer.dart';
import 'package:Mr.musik/widgets/snakbar.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../functions/play.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
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
            child: ValueListenableBuilder(
              valueListenable: fav,
              builder: (context, value, child) {
                if(value.isEmpty){
                          return Center(child: Text('Favorite Empty' ,style: TextStyle(fontSize: 20, color: Colors.black)),);
                        }
                return ListView.builder(
                    padding: EdgeInsets.only(top: 8),
                    itemCount: fav.value.length,
                    itemBuilder: (context, index) {
                      return 
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  right: 8, left: 8, bottom: 8),
                              child: InkWell(
                                  onTap: () {
                                    playAudio(fav.value, index);
      
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
                                            child: Text(
                                              'Remove From Favour',
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
                                      onSelected: (value) {
                                        if (value == 0) {
                                          removeFromFav(fav.value[index].id);
                                          SnackBarShowForFavoriteRemove(context);
                                        } else if (value == 1) {
                                          // showPopupScreen(context);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlayListAdding(addingsong: fav.value[index]),
                                                ));
                                        }
                                      },
                                    ),
                                    leading: QueryArtworkWidget(
                                      size: 3000,
                                      quality: 100,
                                      artworkQuality: FilterQuality.high,
                                      artworkBorder: BorderRadius.circular(7),
                                      artworkFit: BoxFit.cover,artworkWidth: MediaQuery.of(context).size.width * 0.15,
                                      id: fav.value[index].id,
                                      type: ArtworkType.AUDIO,
                                      nullArtworkWidget: ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child: Image.asset(
                                          'assets/images/lead.jpeg',width: MediaQuery.of(context).size.width * 0.15,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    title: Text(fav.value[index].songname!,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.oswald(
                                          fontWeight: FontWeight.w500,
                                        )),
                                    subtitle: Text(
                                        fav.value[index].artist ?? 'unknown',
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.oswald()),
                                  
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

