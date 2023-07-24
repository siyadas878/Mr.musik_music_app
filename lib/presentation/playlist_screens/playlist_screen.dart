import 'package:Mr.musik/applications/playlist_bloc/play_list_bloc.dart';
import 'package:Mr.musik/presentation/now_playing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mr.musik/presentation/playlist_screens/Playlist_list.dart';


// ignore: must_be_immutable
class PlayListScreen extends StatelessWidget {
  PlayListScreen({super.key});

  TextEditingController rename = TextEditingController();

  final formKeyRename = GlobalKey<FormState>();

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
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: CreaateAppBar(context),
            ),
            const Divider(
              color: Color(0xFFF0ECC2),
            ),
            Expanded(
              child: BlocBuilder<PlayListBloc, PlayListState>(
                builder: (context, playlistState) {
                  if (playlistState.playlist.isEmpty) {
                    return Center(
                      child: Text('PlayList Empty',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                    );
                  }

                  return GridView.builder(
                      padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                      itemCount: playlistState.playlist.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlayListListScreen(
                                      currenPlaylistindex:
                                          playlistState.playlist[index],
                                      idx: index),
                                ));
                          },
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Image.asset(
                                  'assets/images/lead.jpeg',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.21,
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      playlistState.playlist[index].name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Color(0xFFF0ECC2),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: PopupMenuButton(
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: Color(0xFFF0ECC2),
                                  ),
                                  color: Color(0xFFF0ECC2),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                        value: 0,
                                        child: Text(
                                          'Delete',
                                          style: GoogleFonts.oswald(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )),
                                    PopupMenuItem(
                                        value: 1,
                                        child: Text(
                                          'Rename',
                                          style: GoogleFonts.oswald(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )),
                                  ],
                                  onSelected: (value) {
                                    if (value == 0) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: Color(0xFFF0ECC2),
                                            title: const Text(
                                                'Do you want to Delete?'),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateColor
                                                            .resolveWith(
                                                                (states) => Color
                                                                    .fromARGB(
                                                                        255,
                                                                        26,
                                                                        35,
                                                                        24))),
                                                child: const Text('Cancel',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFF0ECC2))),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateColor
                                                            .resolveWith(
                                                                (states) => Color
                                                                    .fromARGB(
                                                                        255,
                                                                        26,
                                                                        35,
                                                                        24))),
                                                child: const Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                      color: Color(0xFFF0ECC2)),
                                                ),
                                                onPressed: () {
                                                  BlocProvider.of<PlayListBloc>(
                                                          context)
                                                      .add(PlaylistDelete(playlistIndex: index, 
                                                      newname: rename.text));
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      // deletePlaylist(playlist.key);
                                    } else if (value == 1) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              backgroundColor:
                                                  Color(0xFFF0ECC2),
                                              title: Text('Change Name'),
                                              content: Form(
                                                key: formKeyRename,
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please Enter name';
                                                    } else if (playlistState
                                                        .playlist[index].name
                                                        .contains(
                                                            rename.text)) {
                                                      return 'This Name Already Exist';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  controller: rename,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: 'Playlist Name',
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  26,
                                                                  35,
                                                                  24)),
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFF0ECC2)),
                                                  ),
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                    rename.clear();
                                                  },
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  26,
                                                                  35,
                                                                  24)),
                                                  child: Text(
                                                    'Rename',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFF0ECC2)),
                                                  ),
                                                  onPressed: () async {
                                                    if (formKeyRename
                                                        .currentState!
                                                        .validate()) {
                                                      BlocProvider.of<
                                                                  PlayListBloc>(
                                                              context)
                                                          .add(PlaylistRename(playlistIndex: index, 
                                                          newname: rename.text));
                                                      // setState(() {
                                                      //   playlistrename(
                                                      //       index,
                                                      //       rename.text);
                                                      // });
                                                      Navigator.of(context)
                                                          .pop();
                                                      rename.clear();
                                                    }
                                                  },
                                                ),
                                              ]);
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
              ),
            ),
            // MiniPLayer()
          ],
        ),
      ),
    );
  }

  Widget CreaateAppBar(BuildContext context) {
    TextEditingController NameOfPlayList = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return BlocBuilder<PlayListBloc, PlayListState>(
      builder: (context, PlaylistState) {
        return AppBar(
          toolbarHeight: 40,
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: false,
          title: Text(
            'My Playlist',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Form(
                        key: formKey,
                        child: AlertDialog(
                            backgroundColor: Color(0xFFF0ECC2),
                            title: Text('Add Name'),
                            content: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter name';
                                } else {
                                  for (var element in PlaylistState.playlist) {
                                    if (element.name == NameOfPlayList.text) {
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
                            actions: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 26, 35, 24)),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: Color(0xFFF0ECC2)),
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);
                                  NameOfPlayList.clear();
                                },
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 26, 35, 24)),
                                child: Text(
                                  'Create',
                                  style: TextStyle(color: Color(0xFFF0ECC2)),
                                ),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    BlocProvider.of<PlayListBloc>(context).add(
                                        PlaylistAdd(playlistIndex: index, newname: NameOfPlayList.text));
                                    Navigator.of(context).pop();
                                    NameOfPlayList.clear();
                                    // setState(() {
                                    //   addPlayList(NameOfPlayList.text);
                                    //   Navigator.of(context).pop();
                                    //   NameOfPlayList.clear();
                                    // });
                                  }
                                },
                              ),
                            ]),
                      );
                    },
                  );
                },
                icon: Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Icon(
                    Icons.playlist_add,
                    color: Color(0xFF000000),
                  ),
                ))
          ],
        );
      },
    );
  }
}
