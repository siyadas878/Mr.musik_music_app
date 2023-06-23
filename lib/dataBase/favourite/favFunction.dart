import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:Mr.musik/dataBase/favourite/favModel.dart';
import 'package:Mr.musik/models/model.dart';
import 'package:Mr.musik/screens/splash.dart';

ValueNotifier<List<Songs>> fav = ValueNotifier([]);

addToFav(int id) async {
  final favDB = await Hive.openBox<FavourModel>('fav_DB');
  await favDB.put(id, FavourModel(id: id));
  for (var elements in allSongs) {
    if (elements.id == id) {
      fav.value.add(elements);
    }
  }
}

Future<void> removeFromFav(int id) async {
  final favDB = await Hive.openBox<FavourModel>('fav_DB');
  await favDB.delete(id);
  for (var element in allSongs) {
    if (element.id == id) {
      fav.value.remove(element);
    }
  }
  fav.notifyListeners();
}

