import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseUser _firebaseUser;

  /// Contém os dados de cadastro do usuário
  Map<String, dynamic> _userData = {};

  /// Indica que está sendo feito alguma operação de autenticação
  bool _isCarregando = false;

  get userData => this._userData;

  get isCarregando => this._isCarregando;


  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _getUsuarioLogado();
  }

  void criarUsuario({ @required Map dados,
                      @required String senha,
                      @required VoidCallback sucessoHandler,
                      @required VoidCallback erroHandler}) async {
    aguardarOperacao();
    await _firebaseAuth.createUserWithEmailAndPassword (
        email: dados['email'],
        password: senha,
    ).then((novoUsuario) async {
      this._firebaseUser = novoUsuario.user;
      await _salvarUsuario(dados);
      sucessoHandler();
      operacaoFinalizada();
    }).catchError((erro){
      print(erro.toString());
      operacaoFinalizada();
      erroHandler();
    });
  }

  void aguardarOperacao(){
    this._isCarregando = true;
    notifyListeners();
  }

  void operacaoFinalizada(){
    this._isCarregando = false;
    notifyListeners();
  }

  Future<Null> _salvarUsuario(Map<String, dynamic> dados) async {
    this._userData = dados;
    await Firestore.instance.collection('users').document(this._firebaseUser.uid).setData(dados);
  }

  Future<Null> _getUsuarioLogado() async {
    if (this._firebaseUser == null) {
      this._firebaseUser = await _firebaseAuth.currentUser();
    }
    if (_firebaseUser != null){
      if (this._userData.isEmpty){
        DocumentSnapshot doc = await Firestore.instance.collection("users").document(_firebaseUser.uid).get();
        this._userData = doc.data;
      }
    }
    notifyListeners();
  }

  void recuperarSenha(String email) async {
    await this._firebaseAuth.sendPasswordResetEmail(email: email);
  }

  void logar({@required String email,
              @required String senha,
              @required VoidCallback sucessoHandler,
              @required VoidCallback erroHandler}) async {

    aguardarOperacao();
    await this._firebaseAuth.signInWithEmailAndPassword(email: email, password: senha)
    .then((firebaseUser) async {
      this._firebaseUser = firebaseUser.user;
      await _getUsuarioLogado();
      sucessoHandler();
      operacaoFinalizada();
    }).catchError((erro){
      erroHandler();
      operacaoFinalizada();
    });
  }

  void sair() async {
    await this._firebaseAuth.signOut();
    this._firebaseUser = null;
    _userData = {};
    notifyListeners();
  }

  bool isLogado(){
    return _firebaseUser != null;
  }

}