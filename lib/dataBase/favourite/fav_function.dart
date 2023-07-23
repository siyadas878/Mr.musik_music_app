import 'package:hive/hive.dart';
import 'package:Mr.musik/dataBase/favourite/fav_model.dart';
// ValueNotifier<List<Songs>> fav = ValueNotifier([]);

Future<void>addfavorite(int id) async {
  Box<FavourModel> favdb = await Hive.openBox('favorite');
  FavourModel temp = FavourModel(id: id);
 await favdb.add(temp);
}


//-----------Song removing to favorite function-----------
removefavorite(int id) async {
  Box<FavourModel> favdb = await Hive.openBox('favorite');
  for (var element in favdb.values) {
    if (id == element.id) {
      var key = element.key;
      favdb.delete(key);
      break;
    }
  }
}