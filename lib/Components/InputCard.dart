import 'package:flutter/material.dart';

class InputCard extends StatelessWidget {
  InputCard({this.labelText, this.onChanged});

  final String labelText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green[50],
      child: Padding(
        padding: EdgeInsets.only(top: 0, bottom: 8, left: 8, right: 8),
        child: Container(
            height: 50,
            child: TextField(
              onChanged: this.onChanged,
              style: TextStyle(color: Colors.green),
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: this.labelText ?? 'label',
              ),
            )),
      ),
    );
  }
}
