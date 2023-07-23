part of 'play_list_bloc.dart';

class PlayListEvent {}

class PlaylistE extends PlayListEvent {
  int? playlistIndex;
  String? newname;
  late bool iscreateing;
  late bool isrenaming;
  late bool isdeleting;

  PlaylistE.createnew({required this.newname}) {
    iscreateing = true;
    isdeleting = false;
    isrenaming = false;
  }

  PlaylistE.isrenaming({
    required this.newname,
    required this.playlistIndex,
  }) {
    iscreateing = false;
    isdeleting = false;
    isrenaming = true;
  }

  PlaylistE.isdeleting({required this.playlistIndex}) {
    iscreateing = false;
    isdeleting = true;
    isrenaming = false;
  }
}

class PlaylistI extends PlayListEvent {
  Songs song;
  int playlistIndex;
  late bool isadding;
  late bool isremoving;

  PlaylistI.songAdding({
    required this.song,
    required this.playlistIndex,
  }) {
    isadding = true;
    isremoving = false;
  }
   PlaylistI.songRemoving({
    required this.song,
    required this.playlistIndex,
  }) {
    isadding = false;
    isremoving = true;
  }
}

class PlaylistFetch extends PlayListEvent{
  
}
