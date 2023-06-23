import 'package:hive/hive.dart';
import 'package:Mr.musik/dataBase/favourite/favFunction.dart';
import 'package:Mr.musik/models/model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../dataBase/favourite/favModel.dart';
import '../dataBase/mostPLayed/MostFunction.dart';
import '../dataBase/playList/EachPlayList.dart';
import '../dataBase/playList/playlistModel.dart';
import '../dataBase/recentlyplayed/recently.dart';
import '../screens/PlayListScreens/playlistScreen.dart';
import '../screens/splash.dart';

class FetchSongs {
  final OnAudioQuery audioquerry = OnAudioQuery();
  requestPermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  songfetch() async {
    bool status = await requestPermission();
    if (status) {
      List<SongModel> fetchsongs = await audioquerry.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL);
      for (SongModel element in fetchsongs) {
        if (element.fileExtension == "mp3") {
          allSongs.add(Songs(
              songname: element.displayNameWOExt,
              artist: element.artist,
              duration: element.duration,
              id: element.id,
              songurl: element.uri));
        }
      }
    }
    await favfetch();
    await recentfetch();
    await playlistfetch();
    await mostplayedfetch();
  }

  
  favfetch() async {
    List<FavourModel> favsongcheck = [];
    Box<FavourModel> favdb = await Hive.openBox('fav_DB');
    favsongcheck.addAll(favdb.values);
    for (var favs in favsongcheck) {
      int count = 0;
      for (var songs in allSongs) {
        if (favs.id == songs.id) {
          fav.value.insert(0, songs);
          break;
        } else {
          count++;
        }
      }
      if (count == allSongs.length) {
        var key = favs.key;
        favdb.delete(key);
      }
    }
  }

    recentfetch() async {
    Box<int> recentDb = await Hive.openBox('recent');
    List<Songs> recenttemp = [];
    for (int element in recentDb.values) {
      for (Songs song in allSongs) {
        if (element == song.id) {
          recenttemp.add(song);
          break;
        }
      }
    }
    recentList.value = recenttemp.reversed.toList();
  }


  playlistfetch() async {
    Box<PlaylistClass> playlistdb = await Hive.openBox('PlayList');
    for (PlaylistClass elements in playlistdb.values) {
      String playlistname = elements.playlistName;
      EachPlaylist playlistfetch = EachPlaylist(name: playlistname);
      for (int id in elements.ListSongs) {
        for (Songs songs in allSongs) {
          if (id == songs.id) {
            playlistfetch.container.add(songs);
            break;
          }
        }
      }
      playListNotifier.value.add(playlistfetch);
    }
  }
   

 mostplayedfetch() async {
  final Box<int> MostPlayedDB = await Hive.openBox('MostPlayed');
  if (MostPlayedDB.isEmpty) {
    for (Songs elements in allSongs) {
      MostPlayedDB.put(elements.id, 0);
    }
  } else {
    for (int id in MostPlayedDB.keys) {
      int count = MostPlayedDB.get(id) ?? 0;
      if (count > 4) {
        for (Songs element in allSongs) {
          if (element.id == id) {
            mostPlayedList.value.add(element);
            break;
          }
        }
      }
    }
    if (mostPlayedList.value.length > 10) {
      mostPlayedList.value = mostPlayedList.value.sublist(0, 10);
    }
  }
}


}
