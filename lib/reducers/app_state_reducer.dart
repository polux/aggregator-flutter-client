// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter_reader/models/models.dart';
import 'package:flutter_reader/reducers/feed_entries_reducer.dart';
import 'package:flutter_reader/reducers/feed_infos_reducer.dart';
import 'package:flutter_reader/reducers/is_loading_feed_entries_reducer.dart';
import 'package:flutter_reader/reducers/is_loading_more_feed_entries_reducer.dart';
import 'package:flutter_reader/reducers/is_loading_feed_infos_reducer.dart';
import 'package:flutter_reader/reducers/visibility_reducer.dart';

// We create the State reducer by combining many smaller reducers into one!
AppState appReducer(AppState state, action) {
  return new AppState(
    isLoadingFeedInfos:
        isLoadingFeedInfosReducer(state.isLoadingFeedInfos, action),
    isLoadingFeedEntries:
        isLoadingFeedEntriesReducer(state.isLoadingFeedEntries, action),
    isLoadingMoreFeedEntries:
        isLoadingMoreFeedEntriesReducer(state.isLoadingMoreFeedEntries, action),
    feedInfos: feedInfosReducer(state.feedInfos, action),
    feedEntries: feedEntriesReducer(state.feedEntries, action),
    activeFilter: visibilityReducer(state.activeFilter, action),
  );
}
