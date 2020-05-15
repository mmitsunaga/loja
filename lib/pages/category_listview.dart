import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/pages/category_screen.dart';

class CategoryListView extends StatelessWidget {

  List<Widget> createListTiles(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
    return snapshot.data.documents.map((DocumentSnapshot doc){
      return ListTile (
        leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(doc.data['img'])
        ),
        title: Text(doc.data['title']),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context){
              return CategoryScreen(doc);
            }
          ));
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection('categorias').getDocuments(),
      builder: (context, snapshot){
        if (!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        } else {
           return Container(
             padding: EdgeInsets.all(10.0),
             child: ListView(
               children: ListTile.divideTiles(tiles: createListTiles(context, snapshot), color: Colors.grey[500]).toList()
             ),
           );
        }
      },
    );
  }

}
