import 'package:flutter/material.dart';
import 'package:loja/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'pages/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel (
      model: UserModel(),
      child: MaterialApp(
          title: 'Adidas Store',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.indigo,
              primaryColor: Colors.blueGrey
          ),
          home: LoginScreen()
      )
    );
  }
}