import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lppapphybrid/Graphql/Events.dart';
import 'package:lppapphybrid/Graphql/State.dart';
import 'package:lppapphybrid/Pages/Localizazao/NovaLocalizacao.dart';
import 'package:lppapphybrid/Repositories/LocalizacaoRepository.dart';

class Localizacao extends StatefulWidget {
  @override
  _LocalizacaoState createState() => _LocalizacaoState();
}

class _LocalizacaoState extends State<Localizacao> {
  Completer<void> _completer;
  LocalizacaoRepository _localizacaoRepository;

  @override
  void initState() {
    super.initState();
    _completer = Completer<void>();
    _localizacaoRepository = BlocProvider.of<LocalizacaoRepository>(context);
  }

  @override
  void dispose() {
    _localizacaoRepository.dispose();
    super.dispose();
  }

  Future _handleRefreshStart(Bloc bloc) {
    bloc.add(GraphqlRefetchEvent<Map<String, dynamic>>());
    return _completer.future;
  }

  void _handleRefreshEnd() {
    _completer?.complete();
    _completer = Completer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Localização"),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _handleRefreshStart(_localizacaoRepository),
        child: BlocBuilder(
            bloc: _localizacaoRepository,
            builder: (_, state) {
              Widget child = Container();
              if (state is GraphqlLoadingState) {
                child = Center(child: CircularProgressIndicator());
              }
              if (state is GraphqlErrorState<Map<String, dynamic>>) {
                _handleRefreshEnd();
                child = ListView(
                  children: [
                    Text(
                      parseOperationException(state.error),
                      style: TextStyle(color: Theme.of(context).errorColor),
                    )
                  ],
                );
              }

              if (state is GraphqlLoaded || state is GraphqlFetchMoreState) {
                _handleRefreshEnd();
                final itemCount = state.data['locations'].length;

                if (itemCount == 0) {
                  child = ListView(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.inbox),
                        SizedBox(width: 8),
                        Text('No data'),
                      ],
                    )
                  ]);
                } else {
                  child = Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: NovaLocalizacao(
                          onSaveComplete: (nome) {
                            print('DONE');
                            _localizacaoRepository.addNova(nome);
                          },
                        ),
                      ),
                      Expanded(
                          child: ListView.separated(
                        separatorBuilder: (_, __) => SizedBox(
                          height: 8.0,
                        ),
                        key: PageStorageKey('reports'),
                        itemCount: itemCount,
                        itemBuilder: (BuildContext context, int index) {
                          final node = state.data['locations'][index];

                          Widget tile = ListTile(
                            title: Card(
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(node['nome']),
                              ),
                            ),
                          );

                          if (state is GraphqlFetchMoreState &&
                              index == itemCount - 1) {
                            tile = Column(
                              children: [
                                tile,
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: CircularProgressIndicator(),
                                ),
                              ],
                            );
                          }

                          return tile;
                        },
                      ))
                    ],
                  );
                }
              }
              return AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: child,
              );
            }),
      ),
    );
  }
}

String parseOperationException(OperationException error) {
  if (error.clientException != null) {
    final exception = error.clientException;

    if (exception is NetworkException) {
      return 'Failed to connect to ${exception.uri}';
    } else {
      return exception.toString();
    }
  }

  if (error.graphqlErrors != null && error.graphqlErrors.isNotEmpty) {
    final errors = error.graphqlErrors;

    return errors.first.message;
  }

  return 'Unknown error';
}
