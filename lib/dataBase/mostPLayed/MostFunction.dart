import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../models/model.dart';



ValueNotifier<List<Songs>> mostPlayedList = ValueNotifier([]);


mostplayedadd(Songs song) async {
  final Box<int> MostPlayedDB = await Hive.openBox('MostPLayed');
  int count = (MostPlayedDB.get(song.id) ?? 0) + 1;
  MostPlayedDB.put(song.id, count);
  if (count > 4 && !mostPlayedList.value.contains(song)) {
    mostPlayedList.value.add(song);
  }
  if (mostPlayedList.value.length > 10) {
    mostPlayedList.value = mostPlayedList.value.sublist(0, 10);
  }
}
