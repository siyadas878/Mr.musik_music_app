import 'package:hive/hive.dart';
part 'playlistModel.g.dart';

@HiveType(typeId: 2)
class PlaylistClass extends HiveObject {

  @HiveField(0)
  String playlistName;

  @HiveField(1)
  List<int> ListSongs=[];

  PlaylistClass({required this.playlistName});

}
