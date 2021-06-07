import 'package:flutter/cupertino.dart';
import 'aposta.dart';

class User {
  final nome;
  final id;
  final idade;
  final senha;
  final List<Aposta> aposta = [];
  User(
      {@required this.nome,
      @required this.id,
      @required this.idade,
      @required this.senha,
      Aposta aposta});
}
