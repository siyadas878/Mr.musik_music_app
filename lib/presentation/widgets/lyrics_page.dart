import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

showlirics(BuildContext context, String lyrics) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Column(children: [
        Expanded(
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  ),
              child: ListView(
                children: [
                  Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            lyrics.replaceAll('Contributor', ''),
                            style: GoogleFonts.play(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ))
                ],
              )),
        )
      ]);
    },
  );
}