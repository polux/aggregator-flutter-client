import 'package:built_collection/built_collection.dart';
// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:meta/meta.dart';
import 'package:flutter_reader/models/models.dart';

@immutable
class AppState {
  final bool isLoadingFeedInfos;
  final BuiltMap<String, bool> isLoadingFeedEntries;
  final BuiltMap<String, bool> isLoadingMoreFeedEntries;
  final BuiltList<FeedInfo> feedInfos;
  final BuiltListMultimap<String, FeedEntry> feedEntries;
  final VisibilityFilter activeFilter;

  AppState(
      {this.isLoadingFeedInfos = false,
      BuiltMap<String, bool> isLoadingFeedEntries,
      BuiltMap<String, bool> isLoadingMoreFeedEntries,
      BuiltList<FeedInfo> feedInfos,
      BuiltListMultimap<String, FeedEntry> feedEntries,
      this.activeFilter = VisibilityFilter.all})
      : this.isLoadingFeedEntries = isLoadingFeedEntries ?? new BuiltMap(),
        this.isLoadingMoreFeedEntries =
            isLoadingMoreFeedEntries ?? new BuiltMap(),
        this.feedInfos = feedInfos ?? new BuiltList(),
        this.feedEntries = feedEntries ?? new BuiltListMultimap();

  AppState copyWith({
    bool isLoadingFeedInfos,
    BuiltMap<String, bool> isLoadingFeedEntries,
    BuiltMap<String, bool> isLoadingMoreFeedEntries,
    BuiltList<FeedInfo> feedInfos,
    BuiltListMultimap<String, FeedEntry> feedEntries,
    VisibilityFilter activeFilter,
  }) {
    return new AppState(
      isLoadingFeedInfos: isLoadingFeedInfos ?? this.isLoadingFeedInfos,
      isLoadingFeedEntries: isLoadingFeedEntries ?? this.isLoadingFeedEntries,
      isLoadingMoreFeedEntries:
          isLoadingMoreFeedEntries ?? this.isLoadingMoreFeedEntries,
      feedInfos: feedInfos ?? this.feedInfos,
      feedEntries: feedEntries ?? this.feedEntries,
      activeFilter: activeFilter ?? this.activeFilter,
    );
  }

  @override
  int get hashCode =>
      isLoadingFeedInfos.hashCode ^
      isLoadingFeedEntries.hashCode ^
      isLoadingMoreFeedEntries.hashCode ^
      feedInfos.hashCode ^
      feedEntries.hashCode ^
      activeFilter.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoadingFeedInfos == other.isLoadingFeedInfos &&
          isLoadingFeedEntries == other.isLoadingFeedEntries &&
          isLoadingMoreFeedEntries == other.isLoadingMoreFeedEntries &&
          feedInfos == other.feedInfos &&
          feedEntries == other.feedEntries &&
          activeFilter == other.activeFilter;

  @override
  String toString() {
    return 'AppState{'
        'isLoadingFeedInfos: $isLoadingFeedInfos, '
        'isLoadingFeedEntries: $isLoadingFeedEntries, '
        'isLoadingMoreFeedEntries: $isLoadingMoreFeedEntries, '
        'feedInfos: $feedInfos, '
        'feedEntries: $feedEntries, '
        'activeFilter: $activeFilter}';
  }
}
