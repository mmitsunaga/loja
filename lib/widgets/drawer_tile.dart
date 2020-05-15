import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final String text;
  final IconData icon;
  final Function onTapHandler;

  DrawerTile(this.text, this.icon, this.onTapHandler);

  @override
  Widget build(BuildContext context) {
   return Material(
     color: Colors.transparent,
     child: InkWell(
       onTap: (){
         onTapHandler();
       },
       child: Container(
         height: 60.0,
         child: Row(
           children: <Widget>[
             Icon(icon, size: 32, color: Colors.black),
             SizedBox(width: 32.0,),
             Text(text, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black))
           ],
         ),
       ),
     ),
   );
  }
}
