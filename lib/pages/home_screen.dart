import 'package:flutter/material.dart';
import 'package:loja/pages/category_listview.dart';
import 'package:loja/pages/home_list_view.dart';
import 'package:loja/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView (
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: <Widget>[
        Scaffold(
          drawer: CustomDrawer(_pageController),
          body: HomeListView(),
        ),
        Scaffold(
          appBar: AppBar(
              title: Text('Produtos'),
              centerTitle: true
          ),
          drawer: CustomDrawer(_pageController),
          body: CategoryListView(),
        ),
        Scaffold(
          drawer: CustomDrawer(_pageController),
          appBar: AppBar(
            title: Text('Nossas lojas'),
            centerTitle: true,
          ),
          body: Container(),
        ),
        Scaffold(
          drawer: CustomDrawer(_pageController),
          appBar: AppBar(
            title: Text('Pedidos'),
            centerTitle: true,
          ),
          body: Container(),
        )
      ],
    );
  }
}

