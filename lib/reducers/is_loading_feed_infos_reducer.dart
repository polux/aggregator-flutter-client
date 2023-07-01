// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:redux/redux.dart';
import 'package:flutter_reader/actions/actions.dart';

final isLoadingFeedInfosReducer = combineReducers<bool>([
  new TypedReducer<bool, LoadFeedInfosAction>(_setLoading),
  new TypedReducer<bool, FeedInfosLoadedAction>(_setLoaded),
  new TypedReducer<bool, FeedInfosNotLoadedAction>(_setLoaded),
]);

bool _setLoading(bool state, action) {
  return true;
}

bool _setLoaded(bool state, action) {
  return false;
}
