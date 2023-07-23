part of 'recently_bloc.dart';

class RecentlyEvent {}

class RecentFetch extends RecentlyEvent{}

class RecentAdd extends RecentlyEvent{
  int songid;
  RecentAdd({required this.songid});
}
