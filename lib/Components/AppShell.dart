import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppShell extends StatelessWidget {
  AppShell({this.title, this.children = const <Widget>[]});

  final List<Widget> children;
  final title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        backgroundColor: Colors.white,
        body: ListView(
            padding: const EdgeInsets.all(8), children: this.children));
  }
}
