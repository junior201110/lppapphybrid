import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lppapphybrid/Components/InputCard.dart';

class NovaLocalizacao extends StatefulWidget {
  final Function(String nome) onSaveComplete;

  const NovaLocalizacao({Key key, this.onSaveComplete}) : super(key: key);

  @override
  _NovaLocalizacaoState createState() => _NovaLocalizacaoState();
}

class _NovaLocalizacaoState extends State<NovaLocalizacao> {
  String nome = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: InputCard(
            labelText: "Novo",
            onChanged: (nextNome) {
              setState(() {
                nome = nextNome;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.green,
            ),
            tooltip: 'Salvar localização',
            onPressed: () {
              if (nome.trim().length < 1) {
                return Fluttertoast.showToast(msg: "Informe o nome");
              }

              widget.onSaveComplete(nome);
            },
          ),
        )
      ],
    );
  }
}
