import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_reader/actions/actions.dart';
import 'package:flutter_reader/models/models.dart';
import 'package:flutter_reader/presentation/feed_infos_list.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

class FeedInfos extends StatelessWidget {
  FeedInfos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return new FeedInfosList(
          loading: vm.loading,
          feedInfos: vm.feedInfos,
          onRefresh: vm.onRefresh,
        );
      },
    );
  }
}

class _ViewModel {
  final BuiltList<FeedInfo> feedInfos;
  final bool loading;
  RefreshCallback onRefresh;

  _ViewModel({
    @required this.feedInfos,
    @required this.loading,
    @required this.onRefresh,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
        feedInfos:
            _filteredFeedInfos(store.state.feedInfos, store.state.activeFilter),
        loading: store.state.isLoadingFeedInfos,
        onRefresh: () {
          //final completer = new Completer<Null>();
          store.dispatch(new LoadFeedInfosAction());
          //return completer.future;
        });
  }

  static BuiltList<FeedInfo> _filteredFeedInfos(
      BuiltList<FeedInfo> feedInfos, VisibilityFilter visibilityFilter) {
    switch (visibilityFilter) {
      case VisibilityFilter.all:
        return feedInfos;
      case VisibilityFilter.unread:
        return (feedInfos.toBuilder()
              ..retainWhere((feedInfo) => feedInfo.unreadCount > 0))
            .build();
      default:
        throw 'unkown visibility filter';
    }
  }
}
