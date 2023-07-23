part of 'favorite_bloc.dart';

class FavoriteEvent {}
  
class GetFavorite extends FavoriteEvent{} 

class AddToFav extends FavoriteEvent{
  final int id;

  AddToFav(this.id);
}

class RemoveFromeFav extends FavoriteEvent{
  final int id;

  RemoveFromeFav(this.id);
}
