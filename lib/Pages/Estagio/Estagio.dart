import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lppapphybrid/Components/AppShell.dart';

class Estagio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: "Estágio",
      children: <Widget>[
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text("teste"),
          ),
        )
      ],
    );
  }
}
