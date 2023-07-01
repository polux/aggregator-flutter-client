import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_reader/actions/actions.dart';
import 'package:flutter_reader/models/models.dart';
import 'package:flutter_reader/presentation/feed_screen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

class FeedView extends StatelessWidget {
  final String feedId;

  FeedView({Key key, @required this.feedId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(feedId, store),
      onInit: (store) {
        if (store.state.feedEntries[feedId].isEmpty) {
          store.dispatch(new LoadFeedEntriesAction(feedId));
        }
      },
      builder: (context, vm) {
        return new FeedScreen(
          loading: vm.loading,
          loadingMore: vm.loadingMore,
          feedId: vm.feedId,
          feedTitle: vm.feedTitle,
          feedEntries: vm.feedEntries,
          onRefresh: vm.onRefresh,
          onScrollToBottom: vm.onScrollToBottom,
          onStarredPressed: vm.onStarredPressed,
        );
      },
    );
  }
}

class _ViewModel {
  final bool loading;
  final bool loadingMore;
  final String feedId;
  final String feedTitle;
  final BuiltList<FeedEntry> feedEntries;
  RefreshCallback onRefresh;
  VoidCallback onScrollToBottom;
  EntryCallback onStarredPressed;

  _ViewModel({
    @required this.loading,
    @required this.loadingMore,
    @required this.feedId,
    @required this.feedTitle,
    @required this.feedEntries,
    @required this.onRefresh,
    @required this.onScrollToBottom,
    @required this.onStarredPressed,
  });

  static _ViewModel fromStore(String feedId, Store<AppState> store) {
    final bool loading = store.state.isLoadingFeedEntries[feedId] ?? false;
    final bool loadingMore =
        store.state.isLoadingMoreFeedEntries[feedId] ?? false;

    return new _ViewModel(
        loading: loading,
        loadingMore: loadingMore,
        feedId: feedId,
        feedTitle: store.state.feedInfos
            .firstWhere((feedInfo) => feedInfo.id == feedId)
            .title,
        feedEntries: store.state.feedEntries[feedId],
        onRefresh: () {
          store.dispatch(new LoadFeedEntriesAction(feedId));
        },
        onScrollToBottom: () {
          if (!loadingMore) {
            store.dispatch(new LoadMoreFeedEntriesAction(feedId));
          }
        },
        onStarredPressed: (feedEntry) {
          store.dispatch(new SetStarredStateAction(
              feedId, feedEntry.id, !feedEntry.starred));
        });
  }
}
