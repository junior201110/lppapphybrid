import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lppapphybrid/Pages/Lesao/Lesao.dart';
import 'package:lppapphybrid/Pages/Localizazao/Localizacao.dart';
import 'dart:io';

import 'package:lppapphybrid/Repositories/LocalizacaoRepository.dart';

void main() => runApp(LppApp());
String get host {
  if (Platform.isAndroid) {
    return 'https://lppappserver.herokuapp.com';
  } else {
    return 'http://localhost:8080';
  }
}

final OptimisticCache cache = OptimisticCache(
  dataIdFromObject: typenameDataIdFromObject,
);

class LppApp extends StatelessWidget {
  GraphQLClient _client() {
    final HttpLink _httpLink = HttpLink(
      uri: '$host/graphql',
    );

    final AuthLink _authLink = AuthLink(
      getToken: () => '',
    );

    final Link _link = _authLink.concat(_httpLink);

    return GraphQLClient(
      cache: cache,
      link: _link,
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.green, // status bar color
      statusBarIconBrightness: Brightness.light, // status bar icons' color
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Lesao(),
      routes: {
        'localizacao': (_) => BlocProvider(
              create: (context) => LocalizacaoRepository(client: _client()),
              child: Localizacao(),
            )
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
