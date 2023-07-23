  import 'package:Mr.musik/presentation/splash.dart';

import '../domain/model.dart';

search(String querry) {
  List<Songs> data = allSongs
      .where((element) =>
          element.songname!.toLowerCase().contains(querry.toLowerCase().trim()))
      .toList();
  return data;
}