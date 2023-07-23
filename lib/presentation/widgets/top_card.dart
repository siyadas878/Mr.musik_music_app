import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TopCard extends StatelessWidget {
  String title;
  String topImg;
  Function? play;
  TopCard({super.key,required this.title,required this.topImg,this.play});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: 
            [Image.asset(
              topImg,
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              left: 20,top: 20,
              child: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_ios_new_sharp)))
          ],
        ),
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFFF0ECC2),
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                  ),
                  Spacer(),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xFF000000),
                    child: IconButton(
                        onPressed: () {
                          play;
                        },
                        icon: Icon(
                          Icons.play_arrow,
                          color: Color(0xFFF0ECC2),
                        )),
                  )
                ],
              ),
            )),
      ],
    );
  }
}
