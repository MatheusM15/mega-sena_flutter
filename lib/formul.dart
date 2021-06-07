import 'package:flutter/material.dart';

class Formulario extends StatefulWidget {
  final void Function(String, int, String) submit;

  Formulario(this.submit);
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final nomeU = TextEditingController();
  final idadeU = TextEditingController();
  final senhaU = TextEditingController();

  _submiter() {
    final nome = nomeU.text;
    final idade = int.parse(idadeU.text);
    final senha = senhaU.text;

    if (nome.isEmpty || idade == 0 || senha.isEmpty) {
      return;
    }
    return widget.submit(nome, idade, senha);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            TextField(
              controller: nomeU,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: idadeU,
              decoration: InputDecoration(labelText: 'Idade:'),
            ),
            TextField(
              obscureText: true,
              controller: senhaU,
              decoration: InputDecoration(labelText: 'Senha:'),
            ),
            Row(
              children: [
                RaisedButton(
                  onPressed: _submiter,
                  child: Text('Cadastrar'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
