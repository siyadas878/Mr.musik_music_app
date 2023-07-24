import 'package:Mr.musik/presentation/now_playing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mr.musik/presentation/widgets/snakbar.dart';
import '../../applications/playlist_bloc/play_list_bloc.dart';
import '../../domain/model.dart';

// ignore: must_be_immutable
class PlayListAdding extends StatelessWidget {
  final Songs addingsong;
  PlayListAdding({super.key, required this.addingsong});

  Widget CreaateAppBar() {
    return AppBar(
      title: Text(
        'Add To Playlist',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      toolbarHeight: 40.0,
    );
  }

  TextEditingController NameOfPlayList = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF555449), Color(0xFFF0ECC2), Color(0xFF555449)],
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Column(
            children: [
              CreaateAppBar(),
              const Divider(
                color: Color(0xFFF0ECC2),
              ),
              ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Color(0xFFF0ECC2))),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return BlocBuilder<PlayListBloc, PlayListState>(
                          builder: (context, state) {
                            return AlertDialog(
                                backgroundColor: Color(0xFFF0ECC2),
                                title: Text('Add Name'),
                                content: Form(
                                  key: formKey,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter name';
                                      } else {
                                        for (var element
                                            in state.playlist) {
                                          if (element.name ==
                                              NameOfPlayList.text) {
                                            return 'The Name already exisrt';
                                          }
                                        }
                                      }
                                      return null;
                                    },
                                    controller: NameOfPlayList,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Playlist Name',
                                    ),
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 26, 35, 24)),
                                    child: Text(
                                      'Cancel',
                                      style:
                                          TextStyle(color: Color(0xFFF0ECC2)),
                                    ),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 26, 35, 24)),
                                    child: Text('Create',
                                        style: TextStyle(
                                            color: Color(0xFFF0ECC2))),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        BlocProvider.of<PlayListBloc>(context)
                                            .add(PlaylistAdd(playlistIndex: index, newname: NameOfPlayList.text));
                                        //  setState(() {
                                        //    addPlayList(NameOfPlayList.text);
                                        //  });
                                        Navigator.of(context).pop();
                                        NameOfPlayList.clear();
                                      }
                                    },
                                  ),
                                ]);
                          },
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.add),
                  label: Text(
                    'Create playList',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  )),
              Expanded(child: BlocBuilder<PlayListBloc, PlayListState>(
                builder: (context, playlistState) {
                  return ListView.builder(
                    padding: EdgeInsets.only(top: 1),
                    itemCount: playlistState.playlist.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Card(
                          color: Color(0xFFF0ECC2),
                          child: InkWell(
                            onTap: () async {
                              if (!playlistState.playlist[index].container
                                  .contains(addingsong)) {
                                BlocProvider.of<PlayListBloc>(context).add(PlaylistSongAdd(
                                  song: addingsong, playlistIndex: index));
                                SnackBarShowForPlaylistAdd(context);
                                playlistState.playlist[index].container
                                    .add(addingsong);
                              } else {
                                SnackBarShowForPlaylist(context);
                              }

                              Navigator.pop(context);
                            },
                            child: ListTile(
                              title: Text(playlistState.playlist[index].name,
                                  style: GoogleFonts.oswald(
                                      fontWeight: FontWeight.bold)),
                              leading: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: const Color(0xFFF0ECC2)),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/lead.jpeg'),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              )),
            ],
          ),
        ));
  }
}
