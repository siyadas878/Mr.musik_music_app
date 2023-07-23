import 'package:bloc/bloc.dart';
import '../../dataBase/playList/EachPlayList.dart';
import '../../dataBase/playList/playlistFunctions.dart';
import '../../infrastructure/fetch.dart';
import '../../domain/model.dart';
part 'play_list_event.dart';
part 'play_list_state.dart';

class PlayListBloc extends Bloc<PlayListEvent, PlayListState> {
  PlayListBloc() : super(PlayListState(playlist: [])) {
    on<PlaylistFetch>((event, emit) async {
      List<EachPlaylist> playlistdata = await playlistfetch();
      return emit(PlayListState(playlist: playlistdata));
    });

    //--------------------------------Playlist creation,deletion and renaming-------------------------------------------

    on<PlaylistE>((event, emit) async {
      if (event.iscreateing) {
        //Playlist creation

        List<EachPlaylist> playlistdata = await playlistcreating(
            playlistName: event.newname!, playlists: state.playlist);
        return emit(PlayListState(playlist: playlistdata));
      } else if (event.isdeleting) {
        //Playlist deletion

        List<EachPlaylist> playlistdata = await playlistdelete(
            playlist: state.playlist, index: event.playlistIndex!);
        return emit(PlayListState(playlist: playlistdata));
      } else {
        //Playlist renaming

        List<EachPlaylist> playlistdata = await playlistrename(
            index: event.playlistIndex!,
            playlist: state.playlist,
            newname: event.newname!);
        return emit(PlayListState(playlist: playlistdata));
      }
    });

    //--------------------------------Playlist song adding and removing----------------------------------------------

    on<PlaylistI>((event, emit) async {
      if (event.isadding) {
        //Song adding to the playlist

        List<EachPlaylist> playlistdata = await songAddToPlaylist(
            addingsong: event.song,
            playlist: state.playlist,
            index: event.playlistIndex);
        return emit(PlayListState(playlist: playlistdata));
      } else {
        //Song remove from playlist

        List<EachPlaylist> playlistdata = await songRemoveFromPlaylist(
            removingsong: event.song,
            playlist: state.playlist,
            index: event.playlistIndex);
        return emit(PlayListState(playlist: playlistdata));
      }
    });
  }
}

