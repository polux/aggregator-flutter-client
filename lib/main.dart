// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_reader/actions/actions.dart';
import 'package:flutter_reader/localization/localizations.dart';
import 'package:flutter_reader/middleware/reader_service_middleware.dart';
import 'package:flutter_reader/models/models.dart';
import 'package:flutter_reader/presentation/home_screen.dart';
import 'package:flutter_reader/presentation/theme.dart';
import 'package:flutter_reader/reducers/app_state_reducer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  // ignore: deprecated_member_use
  MaterialPageRoute.debugEnableFadingRoutes = true;
  runApp(new ReaderApp());
}

class ReaderApp extends StatelessWidget {
  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState(),
    middleware: createReaderServiceMiddleware(),
  );

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
          // TODO: figure out why ReaderLocalizations.of(context) returns null
          title: new ReaderLocalizations(const Locale("en")).appTitle,
          theme: ReaderTheme.theme,
          localizationsDelegates: [
            new ReaderLocalizationsDelegate(),
          ],
          home: new StoreBuilder<AppState>(
            onInit: (store) {
              store.dispatch(new LoadFeedInfosAction());
            },
            builder: (context, store) {
              return new HomeScreen();
            },
          )),
    );
  }
}
