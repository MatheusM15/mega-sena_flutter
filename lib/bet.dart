import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Bet extends StatefulWidget {
  final id;
  Bet(this.id);

  @override
  _BetState createState() => _BetState();
}

class _BetState extends State<Bet> {
  AppBar appBar = AppBar(
    centerTitle: true,
    title: Text(
      'Apostar',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
  final apostar = TextEditingController();
  List modificada;

  _fazerApostar() {
    if (_apostar()) {
      print('enviou');
      Uri url = Uri.parse(
          'https://flutter-project1-ae97b-default-rtdb.firebaseio.com/users/${widget.id}.json');
      http.patch(url, body: jsonEncode({'apostar': apostar.text}));
    }
  }

  _apostar() {
    modificada = apostar.text.split('');
    if (modificada.length < 6) {
      return false;
    }

    for (int i = 0; i < modificada.length; i++) {
      int quant = 0;
      for (int x = 0; x < modificada.length; x++) {
        if (modificada[i] == modificada[x]) {
          quant++;
        }
        if (modificada[x] == '.' || modificada[x] == ',') {
          return false;
        }
      }
      if (quant > 1) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: appBar,
        body: Container(
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: apostar,
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
                    labelText: 'Apostar'),
                maxLength: 6,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () => _fazerApostar(),
              child: Text('Apostar'),
            )
          ]),
        ),
      ),
    );
  }
}
