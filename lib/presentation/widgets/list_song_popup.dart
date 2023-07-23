import 'package:flutter/material.dart';
import 'package:Mr.musik/presentation/splash.dart';
import 'package:on_audio_query/on_audio_query.dart';

ListSongPopup(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        color: Color.fromARGB(255, 26, 35, 24),
        height: MediaQuery.of(context).size.height * 0.5,
        child: ListView.builder(
          itemCount: allSongs.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Card(
                color: Color(0xFFF0ECC2),
                child: ListTile(
                  trailing: IconButton(
                      onPressed: () {
                        
                        // playlistaddDB(allSongs[index], PlayListnames.value[index].playlistName);
                      },
                      icon: Icon(Icons.add)),
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
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle()),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
