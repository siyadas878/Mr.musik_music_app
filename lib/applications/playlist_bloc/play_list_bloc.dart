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

    on<PlaylistAdd>((event, emit) async {
      await playlistcreating(
          playlistName: event.newname, playlists: state.playlist);
      List<EachPlaylist> playlistdata = await playlistfetch();
      return emit(PlayListState(playlist: playlistdata));
    });

    on<PlaylistDelete>((event, emit) async {
      await playlistdelete(
          playlist: state.playlist, index: event.playlistIndex);
      List<EachPlaylist> playlistdata = await playlistfetch();
      return emit(PlayListState(playlist: playlistdata));
    });

    on<PlaylistRename>((event, emit) async {
      await playlistrename(
          index: event.playlistIndex,
          playlist: state.playlist,
          newname: event.newname);
      List<EachPlaylist> playlistdata = await playlistfetch();
      return emit(PlayListState(playlist: playlistdata));
    });

    on<PlaylistSongAdd>((event, emit) async {
      await songAddToPlaylist(addingsong: event.song, playlist: state.playlist, index: event.playlistIndex);
      List<EachPlaylist> playlistdata = await playlistfetch();
      return emit(PlayListState(playlist: playlistdata));
    });

    on<PlaylistRemoveSong>((event, emit) async {
      await songRemoveFromPlaylist(removingsong: event.song, playlist: state.playlist, index: event.playlistIndex);
      List<EachPlaylist> playlistdata = await playlistfetch();
      return emit(PlayListState(playlist: playlistdata));
    });

  }
}
