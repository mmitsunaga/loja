import 'package:flutter/material.dart';
import 'package:loja/model/user_model.dart';
import 'package:loja/pages/login_screen.dart';
import 'package:loja/widgets/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController controller;

  CustomDrawer(this.controller);

  Widget _buildBackgroundGradientColor(){
    return Container (
      decoration: BoxDecoration (
          color: Color.fromARGB(255, 255, 230, 230),
          /*gradient: LinearGradient (
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 253, 181, 168),
                Color.fromARGB(255, 255, 230, 230)
              ]
          )*/
      ),
    );
  }

  void _jumpToPage (BuildContext context, int pageIndex){
    Navigator.of(context).pop();
    controller.jumpToPage(pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildBackgroundGradientColor(),
          ListView(
            padding: EdgeInsets.only(top: 16.0, left: 32.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 140.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 20.0,
                      left: 0.0,
                      child: Text('Adidas Store', style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
                    ),
                    Positioned(
                      left: 0.0,
                      top: 70.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model){
                          /// nome do usuário logado
                          String nomeUsuario = model.isLogado() ? model.userData['nome'] : "";
                          /// Entre / cadastra-se / sair
                          String labelMenu = model.isLogado() ? "Sair" : "Entre ou cadastre-se";
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Olá, $nomeUsuario', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                              GestureDetector(
                                onTap: (){
                                  if (model.isLogado()){
                                    model.sair();
                                  }
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (context) => LoginScreen()
                                  ));
                                },
                                child: Text(labelMenu,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                              ),
                            ],
                          );
                        }
                      )
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile('Início', Icons.home, (){
                _jumpToPage(context, 0);
              }),
              DrawerTile('Produtos', Icons.list, (){
                _jumpToPage(context, 1);
              }),
              DrawerTile('Lojas', Icons.location_on, (){
                _jumpToPage(context, 2);
              }),
              DrawerTile('Pedidos', Icons.playlist_add_check, (){
                _jumpToPage(context, 3);
              })
            ],
          )
        ],
      )
    );
  }
}
