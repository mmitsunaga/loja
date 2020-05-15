import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/pages/category_detail.dart';

class CategoryTile extends StatelessWidget {

  final String type;

  final DocumentSnapshot doc;

  CategoryTile(this.type, this.doc);

  bool isGrid(){
    return this.type == 'grid';
  }

  Widget buildGridTiles(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AspectRatio (
          aspectRatio: 0.8,
          child: Image.network(doc.data['img'], fit: BoxFit.cover),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${doc.data['title']}',
                  style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)
                ),
                Text('R\$ ${doc.data['price']}',
                    style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor)
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildListTiles(BuildContext context){
    return Row (
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Image.network(doc.data['img'], fit: BoxFit.cover, height: 250.0, width: 250.0),
        ),
        Flexible(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${doc.data['title']}',
                    style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)
                ),
                Text('R\$ ${doc.data['price']}',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor)
                )
              ],
            ),
          ),
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
   return InkWell(
     onTap: (){
       Navigator.of(context).push(MaterialPageRoute(
           builder: (context){
             return CategoryDetail(doc);
           }
       ));
     },
     child: Card(
       child: isGrid() ? buildGridTiles(context) : buildListTiles(context),
     ),
   );
  }

}
