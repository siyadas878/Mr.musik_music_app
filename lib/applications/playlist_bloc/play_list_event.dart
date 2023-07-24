part of 'play_list_bloc.dart';

class PlayListEvent {}

class PlaylistAdd extends PlayListEvent {
  int playlistIndex;
  String newname;
  PlaylistAdd({required this.playlistIndex,required this.newname});
}

class PlaylistDelete extends PlayListEvent {
  int playlistIndex;
  String newname;
  PlaylistDelete({required this.playlistIndex,required this.newname});
}

class PlaylistRename extends PlayListEvent {
  int playlistIndex;
  String newname;
  PlaylistRename({required this.playlistIndex,required this.newname});
}


class PlaylistSongAdd extends PlayListEvent {
  Songs song;
  int playlistIndex;
PlaylistSongAdd({required this.song,required this.playlistIndex});
}

class PlaylistRemoveSong extends PlayListEvent {
  Songs song;
  int playlistIndex;
PlaylistRemoveSong({required this.song,required this.playlistIndex});
}

class PlaylistFetch extends PlayListEvent{
  
}
