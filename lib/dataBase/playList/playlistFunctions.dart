import 'package:hive/hive.dart';
import 'package:Mr.musik/dataBase/playList/EachPlayList.dart';
import 'package:Mr.musik/dataBase/playList/playlistModel.dart';
import '../../domain/model.dart';

//------------------------------create a playlist---------------------------------
Future<List<EachPlaylist>> playlistcreating(
    {required String playlistName,
    required List<EachPlaylist> playlists}) async {
  playlists.add(EachPlaylist(name: playlistName));
  Box<PlaylistClass> playlistdb = await Hive.openBox('playlist');
  playlistdb.put(playlistName, PlaylistClass(playlistName: playlistName));
  return playlists;
}

//------------------------------playlist deleting---------------------------------
Future<List<EachPlaylist>> playlistdelete(
    {required List<EachPlaylist> playlist, required int index}) async {
  Box<PlaylistClass> playlistdb = await Hive.openBox('playlist');
  playlistdb.delete(playlist[index].name);
  playlist.removeAt(index);
  return playlist;
}

//------------------------------playlist renaming---------------------------------
Future<List<EachPlaylist>> playlistrename(
    {required int index,
    required List<EachPlaylist> playlist,
    required String newname}) async {
  String key = playlist[index].name;
  Box<PlaylistClass> playlistdb = await Hive.openBox('playlist');
  PlaylistClass updating = playlistdb.get(key)!;
  updating.playlistName = newname;
  playlistdb.put(key, updating);
  playlist[index].name = newname;
  return playlist;
}

//-----------------------------Songs adding to playlist---------------------------
Future<List<EachPlaylist>> songAddToPlaylist(
    {required Songs addingsong,
    required List<EachPlaylist> playlist,
    required int index}) async {
  Box<PlaylistClass> playlistdb = await Hive.openBox('playlist');
  String key = playlist[index].name;
  playlist[index].container.add(addingsong);
  PlaylistClass updateingPlaylist = playlistdb.get(key)!;
  updateingPlaylist.ListSongs.add(addingsong.id);
  playlistdb.put(key, updateingPlaylist);
  return playlist;
}

//-----------------------------Song remove from playlist--------------------------
Future<List<EachPlaylist>> songRemoveFromPlaylist(
    {required Songs removingsong,
    required List<EachPlaylist> playlist,
    required int index}) async {
  Box<PlaylistClass> playlistdb = await Hive.openBox('playlist');
  String key = playlist[index].name;
  PlaylistClass updateplaylist = playlistdb.get(key)!;
  int itemidx = 0;
  for (int i = 0; i < updateplaylist.ListSongs.length; i++) {
    if (updateplaylist.ListSongs[i] == removingsong.id) {
      itemidx = i;
    }
  }
  updateplaylist.ListSongs.removeAt(itemidx);
  playlistdb.put(key, updateplaylist);
  return playlist;
}
