import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:megasena_app/dados/user.dart';
import 'package:http/http.dart' as http;

class Makebet extends StatefulWidget {
  @override
  _MakebetState createState() => _MakebetState();
}

class _MakebetState extends State<Makebet> {
  Future<void> getUser() async {
    Uri url = Uri.parse(
        'https://flutter-project1-ae97b-default-rtdb.firebaseio.com/users.json');
    final response = await http.get(url);
    print(jsonDecode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        children: [
          TextField(
            maxLength: 6,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: 'Digite suas aposta:'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DropdownButton(items: null, onChanged: null),
              RaisedButton(
                color: Colors.black,
                onPressed: getUser,
                child: Text(
                  'Apostar',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
