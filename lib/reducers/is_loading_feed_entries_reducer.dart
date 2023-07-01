import 'package:built_collection/built_collection.dart';
// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:redux/redux.dart';
import 'package:flutter_reader/actions/actions.dart';

final isLoadingFeedEntriesReducer = combineReducers<BuiltMap<String, bool>>([
  new TypedReducer<BuiltMap<String, bool>, LoadFeedEntriesAction>(_setLoading),
  new TypedReducer<BuiltMap<String, bool>, FeedEntriesLoadedAction>(_setLoaded),
]);

BuiltMap<String, bool> _setLoading(
    BuiltMap<String, bool> state, LoadFeedEntriesAction action) {
  return (state.toBuilder()..[action.feedId] = true).build();
}

BuiltMap<String, bool> _setLoaded(
    BuiltMap<String, bool> state, FeedEntriesLoadedAction action) {
  return (state.toBuilder()..[action.feedId] = false).build();
}
