import 'package:flutter/material.dart';
import 'package:lppapphybrid/Components/AppShell.dart';
import 'package:lppapphybrid/Components/ClicableCard.dart';
import 'package:lppapphybrid/Components/InputCard.dart';

class Lesao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: "Lesão",
      children: <Widget>[
        ClicableCard(
          title: 'Localização',
          description: 'Ex: Occiptal',
          onTap: () {
            Navigator.of(context).pushNamed('localizacao');
          },
        ),
        ClicableCard(
          title: 'Estágio',
          description: 'Ex: Estágio 1',
          onTap: () {
            Navigator.of(context).pushNamed('localizacao');
          },
        ),
        ClicableCard(title: 'Nível de exsudato', description: 'Ex: Baixo'),
        InputCard(
          labelText: 'Largura (cm)',
        ),
        InputCard(
          labelText: 'Comprimento (cm)',
        ),
        InputCard(
          labelText: 'Profundidade (cm)',
        ),
      ],
    );
  }
}
