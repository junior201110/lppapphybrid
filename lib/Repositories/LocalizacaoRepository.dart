import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lppapphybrid/Graphql/Events.dart';
import 'package:lppapphybrid/Graphql/GraphqlBloc.dart';
import 'package:lppapphybrid/Repositories/Localizacao/NovaLocalizacao.dart';

class LocalizacaoRepository extends GraphqlBloc<Map<String, dynamic>> {
  LocalizacaoRepository({GraphQLClient client, WatchQueryOptions options})
      : super(
          client: client,
          options: options ?? WatchQueryOptions(documentNode: parseString(r'''
                  query GetLocations {
                    locations: retornarLocalizacoes {
                      id
                      nome
                    }
                  }             
                ''')),
        );

  @override
  Map<String, dynamic> parseData(Map<String, dynamic> data) {
    return data;
  }

  void addNova(String nome) async {
    final MutationOptions _options = MutationOptions(
      documentNode: parseString(
        r"""
          mutation NovaLocalizacao($nome : String!) {
            createLocalizacao(data: {nome: $nome}){
              id
              nome
            }
          }
      """,
      ),
      variables: <String, dynamic>{
        'nome': nome,
      },
    );
    add(GraphqlLoadingEvent<Map<String, dynamic>>(result: null));

    try {
      final result = await client.mutate(_options);
      if (result.exception == null) {
        Fluttertoast.showToast(msg: 'Localização salva com sucesso');
        add(GraphqlRefetchEvent<Map<String, dynamic>>());
      } else {
        final error = result.exception.graphqlErrors[0].message;
        final total = result.exception.graphqlErrors.length - 1;
        add(GraphqlRefetchEvent<Map<String, dynamic>>());
        Fluttertoast.showToast(
            msg: '$error' + (total > 0 ? ' e mais $total erros' : ''),
            toastLength: Toast.LENGTH_LONG);
      }
    } catch (_, trace) {
      add(GraphqlRefetchEvent<Map<String, dynamic>>());
      debugPrintStack(stackTrace: trace);
      Fluttertoast.showToast(msg: 'Erro ao salvar a localização');
    }
  }
}
