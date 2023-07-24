import 'package:hive/hive.dart';
import 'package:Mr.musik/domain/model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../dataBase/favourite/fav_model.dart';
import '../dataBase/playList/EachPlayList.dart';
import '../dataBase/playList/playlistModel.dart';
import '../presentation/splash.dart';


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
  }

  
  Future<List<Songs>> favfetch() async {
    List<FavourModel> favsongcheck = [];
    Box<FavourModel> favdb = await Hive.openBox('favorite');
    favsongcheck.addAll(favdb.values);
    List<Songs> favorite = [];
    for (var favs in favsongcheck) {
      int count = 0;
      for (var songs in allSongs) {
        if (favs.id == songs.id) {
          favorite.insert(0, songs);
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
    return favorite;
  }

   Future<List<Songs>> recentfetch() async {
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
    return recenttemp.reversed.toList();
  }


Future<List<EachPlaylist>> playlistfetch() async {
  Box<PlaylistClass> playlistdb = await Hive.openBox('playlist');
  List<EachPlaylist> playlist = [];
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
    playlist.add(playlistfetch);
  }
  return playlist;
}
   


Future<List<Songs>> mostplayedfetch() async {
  Box<int> mostplayedDb = await Hive.openBox('mostplayed');
  List<Songs> mostplayedlist = [];
  if (mostplayedDb.isEmpty) {
    for (Songs song in allSongs) {
      mostplayedDb.put(song.id, 0);
    }
  } else {
    List<List<int>> mostplayedTemp = [];
    for (Songs song in allSongs) {
      int count = mostplayedDb.get(song.id)!;
      mostplayedTemp.add([song.id, count]);
    }
    for (int i = 0; i < mostplayedTemp.length - 1; i++) {
      for (int j = i + 1; j < mostplayedTemp.length; j++) {
        if (mostplayedTemp[i][1] < mostplayedTemp[j][1]) {
          List<int> temp = mostplayedTemp[i];
          mostplayedTemp[i] = mostplayedTemp[j];
          mostplayedTemp[j] = temp;
        }
      }
    }
    List<List<int>> temp = [];
    for (int i = 0; i < mostplayedTemp.length && i < 10; i++) {
      temp.add(mostplayedTemp[i]);
    }
    mostplayedTemp = temp;
    for (List<int> element in mostplayedTemp) {
      for (Songs song in allSongs) {
        if (element[0] == song.id && element[1] > 3) {
          mostplayedlist.add(song);
        }
      }
    }
  }
  return mostplayedlist;
}



