import 'package:flutter/material.dart';
import 'package:loja/model/user_model.dart';
import 'package:loja/pages/home_screen.dart';
import 'package:loja/pages/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  void _erroHandler(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Email ou senha inválidos !! Tente novamente',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              )
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
              child: Text('Criar nova conta'),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignUpScreen())
                );
              }
          )
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          if (model.isCarregando){
            return Center(child: CircularProgressIndicator());
          }
          return Form (
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                TextFormField (
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: (text){
                    bool emailOk = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text);
                    return (!emailOk) ?  'O email está inválido' : null;
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _senhaController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Senha'
                  ),
                  validator: (text){
                    bool emailOk = RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$").hasMatch(text);
                    return (!emailOk) ?  'A senha está inválida' : null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                      child: Text('Esqueci minha senha', textAlign: TextAlign.right),
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        if (_emailController.text.isEmpty){
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text('Informe o email para recuperação da senha',
                                    style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                backgroundColor: Colors.red,
                              )
                          );
                        } else {
                          model.recuperarSenha(_emailController.text);
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text('Confira seu email',
                                    style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                backgroundColor: Theme.of(context).primaryColor,
                              )
                          );
                        }
                      }
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox (
                  height: 44.0,
                  child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: Text('Entrar', style: TextStyle(fontSize: 18.0)),
                      onPressed: (){
                        if (_formKey.currentState.validate()){
                          model.logar (
                              email: _emailController.text,
                              senha: _senhaController.text,
                              sucessoHandler: (){
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) => HomeScreen())
                                );
                              },
                              erroHandler: _erroHandler
                          );
                        }
                      }
                  )
                )
              ],
            ),
          );
        }
      )
    );
  }
}
