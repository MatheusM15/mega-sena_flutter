import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:megasena_app/dados/user.dart';
import 'bet.dart';

class Makebet extends StatefulWidget {
  const Makebet({Key key}) : super(key: key);

  @override
  _MakebetState createState() => _MakebetState();
}

class _MakebetState extends State<Makebet> {
  final nome = TextEditingController();
  final senha = TextEditingController();
  List<User> _userLogin = [];

  _validar() {
    bool success = false;
    getUserFire();
    print(_userLogin);
    _userLogin.forEach((element) {
      if (element.nome.toString() == nome.text &&
          element.senha.toString() == senha.text) {
        return Navigator.push(
            context, MaterialPageRoute(builder: (context) => Bet(element.id)));
      }
    });

    _showAlert(context);
  }

  _showAlert(BuildContext context) {
    Widget okButton = FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('ok'));
    AlertDialog alert = AlertDialog(
      title: Text('Error no login'),
      content: Text('Não exister nenhum login com esse usuarios'),
      actions: [okButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  Future<void> getUserFire() async {
    Uri url = Uri.parse(
        'https://flutter-project1-ae97b-default-rtdb.firebaseio.com/users.json');
    final reponse = await http.get(url);
    Map<String, dynamic> data = jsonDecode(reponse.body);
    data.forEach((key, value) {
      final newUser = User(
          nome: value['Nome'],
          id: key,
          idade: value['Idade'],
          senha: value['Senha']);
      setState(() {
        _userLogin.add(newUser);
      });
    });
  }

  AppBar appBar = AppBar(
    title: Text('teste'),
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nome,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(color: Colors.red)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(color: Colors.red)),
                    labelText: 'Nome:',
                    labelStyle: TextStyle(color: Colors.blue, fontSize: 15)),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                controller: senha,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(color: Colors.red)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(color: Colors.red)),
                    labelText: 'Senha:',
                    labelStyle: TextStyle(color: Colors.blue, fontSize: 15)),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: () => _validar(),
                child: Text('Entrar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
