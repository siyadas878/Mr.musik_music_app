import 'package:genius_lyrics/genius_lyrics.dart';

final genius=Genius(accessToken: 'kvMK32Avaf0eG_8N4e77uc01qX6GoPjKm84Ddgt1jrPJqwNEOwrlOL3GAgvBOcAh');

fetchlyrics(String title, String artist) async {
  Song? song = await genius.searchSong(artist: artist, title: title);
  return song!.lyrics;
}
