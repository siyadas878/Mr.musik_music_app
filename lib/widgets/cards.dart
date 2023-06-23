import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CardList extends StatelessWidget {
  String images;
  String texts;
  CardList({super.key,required this.images,required this.texts});

  @override
  Widget build(BuildContext context) {
    return Container(
    margin: const EdgeInsets.only(left: 10),
    height: MediaQuery.of(context).size.height * 1.5,
    width: MediaQuery.of(context).size.width * 0.47,
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: const Color(0xFFF0ECC2),
      child: ClipRRect(  borderRadius: const BorderRadius.all(Radius.circular(25)),
        child: Stack(
          children: [
            SizedBox(                  height: MediaQuery.of(context).size.height * 1.5,
      
      
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                child: Image.asset(images,
                
                width: double.infinity,fit: BoxFit.cover,)),
            ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015,),
            Positioned(bottom: 0,
            child: Container( width: MediaQuery.of(context).size.width * 0.47,
              color: Color(0xFFF0ECC2),
            child: Padding(
              padding: const EdgeInsets.only(left: 15,top: 5,bottom: 7),
              child: Text(texts,style: GoogleFonts.oswald(fontWeight: FontWeight.bold,)),
            )),
              // child: Row(
              //   children: [
              //      Container(
              //       color: Color(0xFFF0ECC2),
              //       child: SizedBox(width: MediaQuery.of(context).size.width * 0.04,)),Text(texts,style: GoogleFonts.oswald(fontWeight: FontWeight.bold,))
              //   ],
              // ),
            )
          ],
        ),
      ),
    ),
    );
  }
}