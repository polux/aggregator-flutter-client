// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_reader/containers/feed_infos.dart';
import 'package:flutter_reader/containers/filter_selector.dart';
import 'package:flutter_reader/localization/localizations.dart';
import 'package:flutter_reader/presentation/keys.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen() : super(key: ReaderKeys.homeScreen);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(ReaderLocalizations.of(context).appTitle),
        actions: [
          new FilterSelector(visible: true),
        ],
      ),
      body: new FeedInfos(),
      floatingActionButton: new FloatingActionButton(
        key: ReaderKeys.addTodoFab,
        onPressed: () {
          Navigator.push(context, null);
        },
        child: new Icon(Icons.add),
        tooltip: ReaderLocalizations.of(context).addTodo,
      ),
      //bottomNavigationBar: new TabSelector(),
    );
  }
}
