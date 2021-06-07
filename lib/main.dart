import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:megasena_app/dados/user.dart';
import 'formul.dart';
import 'makeBet.dart';

void main() => runApp(MaterialApp(
      title: 'Mega sena',
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<User> user = [];

  _addUser(String nome, int idade, String senha) {
    Uri url = Uri.parse(
        'https://flutter-project1-ae97b-default-rtdb.firebaseio.com/users.json');
    http.post(url,
        body: json.encode({'Nome': nome, 'idade': idade, 'Senha': senha}));
    final newUser = User(
        nome: nome,
        id: Random().nextDouble().toString(),
        idade: idade,
        senha: senha,
        aposta: null);
    setState(() {
      user.add(newUser);
    });
    Navigator.pop(context);
  }

  AppBar appbar = AppBar(
    title: Text('teste'),
  );

  _openformularioCadastro(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Formulario(_addUser);
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: appbar,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Image.asset('assets/img/mega-sena-logo.png'),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: RaisedButton(
                  color: Colors.black,
                  onPressed: () => _openformularioCadastro(context),
                  child: Text(
                    'Cadastrar apostador',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: RaisedButton(
                  color: Colors.black,
                  onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Makebet()))
                  },
                  child: Text(
                    'Apostar',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
