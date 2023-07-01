// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter_reader/actions/actions.dart';
import 'package:flutter_reader/middleware/reader_service.dart' as service;
import 'package:flutter_reader/models/models.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createReaderServiceMiddleware() {
  final loadFeedInfos = _createLoadFeedInfos();
  final loadFeedEntries = _createLoadFeedEntries();
  final loadMoreFeedEntriesAction = _createLoadMoreFeedEntries();
  final openFeedEntry = _createOpenFeedEntry();
  final setReadState = _createSetReadState();
  final setStarredState = _createSetStarredState();

  return [
    new TypedMiddleware<AppState, LoadFeedInfosAction>(loadFeedInfos),
    new TypedMiddleware<AppState, LoadFeedEntriesAction>(loadFeedEntries),
    new TypedMiddleware<AppState, LoadMoreFeedEntriesAction>(
        loadMoreFeedEntriesAction),
    new TypedMiddleware<AppState, OpenFeedEntryAction>(openFeedEntry),
    new TypedMiddleware<AppState, SetReadStateAction>(setReadState),
    new TypedMiddleware<AppState, SetStarredStateAction>(setStarredState),
  ];
}

Middleware<AppState> _createLoadFeedInfos() {
  return (Store<AppState> store, action, NextDispatcher next) {
    service
        .getFeedInfos()
        .then(
            (feedInfos) => store.dispatch(new FeedInfosLoadedAction(feedInfos)))
        .catchError((e) => store.dispatch(new FeedInfosNotLoadedAction(e)));
    next(action);
  };
}

Middleware<AppState> _createLoadFeedEntries() {
  return (Store<AppState> store, action, NextDispatcher next) {
    final feedId = (action as LoadFeedEntriesAction).feedId;
    service
        .getFeedEntries(feedId)
        .then((feedEntries) =>
            store.dispatch(new FeedEntriesLoadedAction(feedId, feedEntries)))
        .catchError((e) => new FeedEntriesNotLoadedAction(feedId, e));
    next(action);
  };
}

Middleware<AppState> _createLoadMoreFeedEntries() {
  return (Store<AppState> store, action, NextDispatcher next) {
    final feedId = (action as LoadMoreFeedEntriesAction).feedId;
    service
        .getFeedEntries(feedId, end: store.state.feedEntries[feedId].last.date)
        .then((feedEntries) => store
            .dispatch(new MoreFeedEntriesLoadedAction(feedId, feedEntries)))
        .catchError((e) => new FeedEntriesNotLoadedAction(feedId, e));
    next(action);
  };
}

Middleware<AppState> _createOpenFeedEntry() {
  return (Store<AppState> store, action, NextDispatcher next) {
    OpenFeedEntryAction loadAction = action as OpenFeedEntryAction;
    final feedId = loadAction.feedId;
    final entryId = loadAction.entryId;
    final entry = store.state.feedEntries[feedId]
        .firstWhere((entry) => entry.id == entryId);
    if (entry.content == null) {
      service.getFeedEntry(feedId, entryId).then((feedEntry) {
        store.dispatch(new FullFeedEntryLoadedAction(feedEntry));
      }).catchError((e) {
        store.dispatch(new FullFeedEntryNotLoadedAction(feedId, entryId, e));
      });
    }
    if (!entry.read) {
      store.dispatch(new SetReadStateStartedAction(feedId, entryId, true));
      service.setFeedEntryReadState(feedId, entryId, true).then((_) {
        store.dispatch(new SetReadStateSucceededAction(feedId, entryId, true));
      }).catchError((e) {
        print(e);
        store.dispatch(new SetReadStateFailedAction(feedId, entryId, e));
      });
    }
    next(action);
  };
}

Middleware<AppState> _createSetReadState() {
  return (Store<AppState> store, action, NextDispatcher next) {
    SetReadStateAction setReadStateAction = action as SetReadStateAction;
    final feedId = setReadStateAction.feedId;
    final entryId = setReadStateAction.entryId;
    final read = setReadStateAction.read;
    store.dispatch(new SetReadStateStartedAction(feedId, entryId, read));
    service.setFeedEntryReadState(feedId, entryId, read).then((_) {
      store.dispatch(new SetReadStateSucceededAction(feedId, entryId, read));
    }).catchError((e) {
      print(e);
      store.dispatch(new SetReadStateFailedAction(feedId, entryId, e));
    });
    next(action);
  };
}

Middleware<AppState> _createSetStarredState() {
  return (Store<AppState> store, action, NextDispatcher next) {
    SetStarredStateAction setStarredStateAction =
        action as SetStarredStateAction;
    final feedId = setStarredStateAction.feedId;
    final entryId = setStarredStateAction.entryId;
    final starred = setStarredStateAction.starred;
    store.dispatch(new SetStarredStateStartedAction(feedId, entryId, starred));
    service.setFeedEntryStarredState(feedId, entryId, starred).then((_) {
      store.dispatch(
          new SetStarredStateSucceededAction(feedId, entryId, starred));
    }).catchError((e) {
      print(e);
      store.dispatch(new SetStarredStateFailedAction(feedId, entryId, e));
    });
    next(action);
  };
}
