import 'package:flutter/material.dart';
import 'package:loja/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _enderecoController = TextEditingController();

  void _sucessoHandler(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Usuário criado com sucesso !!'),
          backgroundColor: Theme.of(context).primaryColor,
          duration: Duration(seconds: 2),
        )
    );
    Future.delayed(Duration(seconds: 2)).then((value){
      Navigator.of(context).pop();
    });
  }

  void _erroHandler(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Falha ao criar o usuário',
              style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold)),
          backgroundColor: Colors.red,
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          // Se o modelo está em modo de espera, mostrar o ícone de espera
          if (model.isCarregando){
            return Center(child: CircularProgressIndicator());
          } else {
            return Form (
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: <Widget>[
                  TextFormField(
                    controller: _nomeController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Nome Completo',
                    ),
                    validator: (text){
                      return (text.isEmpty) ?  'O nome é um campo obrigatório !' : null;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
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
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _enderecoController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Endereço',
                    ),
                    validator: (text){
                      return (text.isEmpty) ?  'O endereço é um campo obrigatório !' : null;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox (
                    height: 44.0,
                    child: RaisedButton(
                      onPressed: (){
                        if (_formKey.currentState.validate()){
                          Map<String, dynamic> userData = {
                            'nome': _nomeController.text,
                            'email' : _emailController.text,
                            'endereco': _enderecoController.text
                          };
                          model.criarUsuario(
                              dados: userData,
                              senha: _senhaController.text,
                              sucessoHandler: _sucessoHandler,
                              erroHandler: _erroHandler
                          );
                        }
                      },
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: Text('Criar Conta', style: TextStyle(fontSize: 18.0),),
                    ),
                  )
                ],
              ),
            );
          }
        }
      )
    );
  }
}
