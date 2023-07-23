part of 'most_bloc.dart';

class MostEvent {}

class MostPlayedFetch extends MostEvent {}

class MostPlayedAdd extends MostEvent {
  int songid;
  MostPlayedAdd({required this.songid});
}
