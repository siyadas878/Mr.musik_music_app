import 'package:hive/hive.dart';
import 'package:Mr.musik/dataBase/playList/EachPlayList.dart';
import 'package:Mr.musik/dataBase/playList/playlistModel.dart';
import 'package:Mr.musik/screens/PlayListScreens/playlistScreen.dart';
import '../../models/model.dart';


Future addPlayList(name) async {
  playListNotifier.value.add(EachPlaylist(name: name));
  Box<PlaylistClass> playlistdb = await Hive.openBox('PlayList');
  playlistdb.add(PlaylistClass(playlistName: name));
  playlistdb.close();
  playListNotifier.notifyListeners();
}


Future playlistdelete(int index) async {
  String playlistname = playListNotifier.value[index].name;
  Box<PlaylistClass> playlistdb = await Hive.openBox('PlayList');
  for (PlaylistClass element in playlistdb.values) {
    if (element.playlistName == playlistname) {
      var key = element.key;
      playlistdb.delete(key);
      break;
    }
  }
  playListNotifier.value.removeAt(index);
  playListNotifier.notifyListeners();
}

Future playlistAddDB(Songs addingSong, String playlistName) async {
  Box<PlaylistClass> playlistdb = await Hive.openBox('PlayList');

  for (PlaylistClass element in playlistdb.values) {
    if (element.playlistName == playlistName) {
      var key = element.key;
      PlaylistClass ubdatePlaylist = PlaylistClass(playlistName: playlistName);
      ubdatePlaylist.ListSongs.addAll(element.ListSongs);
      ubdatePlaylist.ListSongs.add(addingSong.id);
      playlistdb.put(key, ubdatePlaylist);
      break;
    }
  }
  playListNotifier.notifyListeners();
}

Future playlistRemoveDB(Songs removingsong,String playlistName) async{
Box<PlaylistClass> playlistdb = await Hive.openBox('PlayList');
  for (PlaylistClass element in playlistdb.values) {
    if (element.playlistName == playlistName) {
      var key = element.key;
      PlaylistClass updateplaylist = PlaylistClass(playlistName: playlistName);
      for (int item in element.ListSongs) {
        if (item == removingsong.id) {
          continue;
        }
        updateplaylist.ListSongs.add(item);
      }
      playlistdb.put(key, updateplaylist);
      break;
    }
  }
  playListNotifier.notifyListeners();
}

Future playlistrename(int index, String newname) async {
  String playlistname = playListNotifier.value[index].name;
  Box<PlaylistClass> playlistdb = await Hive.openBox('PlayList');
  for (PlaylistClass element in playlistdb.values) {
    if (element.playlistName == playlistname) {
      var key = element.key;
      element.playlistName = newname;
      playlistdb.put(key, element);
    }
  }
  playListNotifier.value[index].name = newname;
  playListNotifier.notifyListeners();
}
