import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja/widgets/category_tile.dart';

class CategoryScreen extends StatelessWidget {

  final DocumentSnapshot doc;

  CategoryScreen(this.doc);

  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(doc.data['title']),
          centerTitle: true,
          bottom: TabBar (
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list))
            ],
            onTap: (index){

            },
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection('categorias').document(doc.documentID).collection('items').getDocuments(),
          builder: (context, snapshot){
            if (!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return TabBarView (
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  GridView.builder(
                      padding: EdgeInsets.all(4.0),
                      itemCount: snapshot.data.documents.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        childAspectRatio: 0.65
                      ),
                      itemBuilder: (context, index){
                        return CategoryTile('grid', snapshot.data.documents[index]);
                      },
                  ),
                  ListView.builder (
                    padding: EdgeInsets.all(4.0),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index){
                      return CategoryTile('list', snapshot.data.documents[index]);
                    }
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
