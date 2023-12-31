import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SongPopup extends StatelessWidget {
  Icon icon;
  SongPopup({super.key,required this.icon});

  @override
  Widget build(BuildContext context) {
    return  PopupMenuButton(
      icon: icon,
              color: Color.fromARGB(255, 26, 35, 24),
              itemBuilder: (context) => 
            [
              PopupMenuItem(child: ElevatedButton(onPressed: (){}, child: Text('Add To Favour',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF0ECC2)
              ),)),
              PopupMenuItem(child: ElevatedButton(onPressed: (){}, child: Text('Add To Playlist' ,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF0ECC2)
              ),))
            ],);
  }
}