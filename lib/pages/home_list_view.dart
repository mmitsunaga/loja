import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeListView extends StatelessWidget {

  Widget _buildBackgroundGradientColor(){
    return Container (
      decoration: BoxDecoration (
        gradient: LinearGradient (
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 211, 118, 130),
            Color.fromARGB(255, 253, 181, 168)
          ]
        )
      ),
    );
  }

  Widget _buildTopBar(){
    return CustomScrollView (
      slivers: <Widget>[
        SliverAppBar(
          floating: true,
          snap: true,
          backgroundColor: Colors.transparent,
          elevation: 2.0,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text("Novidades"),
            centerTitle: true,
          ),
        ),
        FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection('home').orderBy('pos').getDocuments(),
          builder: _myFutureBuilder
        )
      ],
    );
  }

  Widget _myFutureBuilder (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
    if (!snapshot.hasData){
      return SliverToBoxAdapter(
        child: Container(
          height: 200.0,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );
    } else {
      return SliverStaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          staggeredTiles: _createStaggeredTile(snapshot),
          children: _createFadeInImage(snapshot)
      );
    }
  }

  List<StaggeredTile> _createStaggeredTile (AsyncSnapshot<QuerySnapshot> snapshot){
    return snapshot.data.documents.map((d){
      return StaggeredTile.count(d.data['x'], d.data['y']);
    }).toList();
  }

  List<FadeInImage> _createFadeInImage (AsyncSnapshot<QuerySnapshot> snapshot){
    return snapshot.data.documents.map((d){
      return FadeInImage.memoryNetwork (
          placeholder: kTransparentImage,
          image: d.data['img'],
          fit: BoxFit.cover
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildBackgroundGradientColor(),
        _buildTopBar()
      ],
    );
  }

}


