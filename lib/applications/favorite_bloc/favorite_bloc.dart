import 'package:bloc/bloc.dart';
import '../../dataBase/favourite/fav_function.dart';
import '../../infrastructure/fetch.dart';
import '../../domain/model.dart';
part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteState(favorite: [])) {
    
    on<GetFavorite>((event, emit) async{
      List<Songs> fav = await favfetch();
      return emit(FavoriteState(favorite: fav));
    });

    on<AddToFav>((event, emit)async {
     await addfavorite(event.id);
     List<Songs> allFavs=await favfetch();
     emit(FavoriteState(favorite:allFavs ));
    });

    on<RemoveFromeFav>((event, emit)async {
    await removefavorite(event.id);
    List<Songs> allFavs=await favfetch();
    emit(FavoriteState(favorite: allFavs));
    });
  }
}
