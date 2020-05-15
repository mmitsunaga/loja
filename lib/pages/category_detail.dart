import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryDetail extends StatefulWidget {

  final DocumentSnapshot document;

  CategoryDetail(this.document);

  // Poderia passar o atributo no construtor de _CategoryDetailState()
  // e na classe, declarar o document e fazer o construtor novo

  @override
  _CategoryDetailState createState() => _CategoryDetailState();

}

class _CategoryDetailState extends State<CategoryDetail> {

  String _selectedSize;

  @override
  Widget build(BuildContext context) {
    final doc = widget.document;
    final List images = doc.data['images'];
    final List sizes = doc.data['sizes'];
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(doc.data['title'],
            style: TextStyle(fontSize: 14.0)
        ),
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              autoplay: false,
              images: images.map((url){
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
            )
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('${doc.data['title']}',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight:
                      FontWeight.w500
                  )
                ),
                Text('R\$ ${doc.data['price']}',
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor
                  )
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text('Tamanho',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight:
                        FontWeight.w500
                    )
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5
                    ),
                    children: sizes.map((size){
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            _selectedSize = size;
                          });
                        },
                        child: Container(
                          width: 50.0,
                          alignment: Alignment.center,
                          child: Text(size),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                              width: 3.0,
                              color: _selectedSize == size ? primaryColor :Colors.grey
                            )
                          ),
                        ),
                      );
                    }).toList()
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    child: Text('Adicionar ao carrinho',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    color: primaryColor,
                    textColor: Colors.white,
                    onPressed: _selectedSize != null ? (){} : null // Se o botão não tiver função no evento (null), ele fica desabilitado
                  ),
                ),
                SizedBox(
                  height: 16.0
                ),
                Text('Descrição',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight:
                        FontWeight.w500
                    )
                ),
                Text('${doc.data['description']}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 12.0
                    )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
