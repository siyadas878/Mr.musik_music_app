import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mr.musik/widgets/popup.dart';


// ignore: must_be_immutable
class MyListView extends StatelessWidget {
  String items;
  String items1;
  MyListView({
    required this.items,
    required this.items1
    // required this.songs,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        trailing:
           SongPopup(icon: Icon(Icons.more_vert),),
        leading: Container(
          height: MediaQuery.of(context).size.width * 1.7,
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFF0ECC2)),
              image: const DecorationImage(
                  image: AssetImage('assets/images/lead.jpeg'),
                  fit: BoxFit.cover)),
        ),
        title: Text(items,overflow: TextOverflow.ellipsis,style: GoogleFonts.oswald(fontWeight: FontWeight.w500,)),
        subtitle:  Text(items1,overflow: TextOverflow.ellipsis,style: GoogleFonts.oswald()),
      ),
    );
  }
}
