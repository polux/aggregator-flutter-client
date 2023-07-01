import 'package:built_collection/built_collection.dart';
import 'package:flutter_reader/models/models.dart';
// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

class LoadFeedInfosAction {}

class FeedInfosLoadedAction {
  final BuiltList<FeedInfo> feedInfos;

  FeedInfosLoadedAction(this.feedInfos);

  @override
  String toString() {
    return 'FeedInfosLoadedAction{feedInfos: $feedInfos}';
  }
}

class FeedInfosNotLoadedAction {
  final dynamic error;

  FeedInfosNotLoadedAction(this.error);

  @override
  String toString() {
    return 'FeedInfosNotLoadedAction{exception: $error}';
  }
}

class LoadFeedEntriesAction {
  final String feedId;

  LoadFeedEntriesAction(this.feedId);

  @override
  String toString() {
    return 'LoadFeedEntriesAction{feedId: $feedId}';
  }
}

class FeedEntriesLoadedAction {
  final String feedId;
  final BuiltList<FeedEntry> feedEntries;

  FeedEntriesLoadedAction(this.feedId, this.feedEntries);

  @override
  String toString() {
    return 'FeedEntriesLoadedAction{feedId: $feedId, FeedEntries: $feedEntries}';
  }
}

class MoreFeedEntriesLoadedAction {
  final String feedId;
  final BuiltList<FeedEntry> feedEntries;

  MoreFeedEntriesLoadedAction(this.feedId, this.feedEntries);

  @override
  String toString() {
    return 'MoreFeedEntriesLoadedAction{feedId: $feedId, FeedEntries: $feedEntries}';
  }
}

class LoadMoreFeedEntriesAction {
  final String feedId;

  LoadMoreFeedEntriesAction(this.feedId);

  @override
  String toString() {
    return 'LoadMoreFeedEntriesAction{feedId: $feedId}';
  }
}

class FeedEntriesNotLoadedAction {
  final String feedId;
  final dynamic error;

  FeedEntriesNotLoadedAction(this.feedId, this.error);

  @override
  String toString() {
    return 'FeedEntriesNotLoadedAction{feedId: $feedId, exception: $error}';
  }
}

class LoadFullFeedEntryAction {
  final String feedId;
  final String entryId;

  LoadFullFeedEntryAction(this.feedId, this.entryId);

  @override
  String toString() {
    return 'LoadFullFeedEntryAction{feedId: $feedId, entryId: $entryId}';
  }
}

class OpenFeedEntryAction {
  final String feedId;
  final String entryId;

  OpenFeedEntryAction(this.feedId, this.entryId);

  @override
  String toString() {
    return 'OpenFeedEntryAction{feedId: $feedId, entryId: $entryId}';
  }
}

class FullFeedEntryLoadedAction {
  final FeedEntry feedEntry;

  FullFeedEntryLoadedAction(this.feedEntry);

  @override
  String toString() {
    return 'FullFeedEntryLoadedAction{feedEnrty: $feedEntry}';
  }
}

class FullFeedEntryNotLoadedAction {
  final String feedId;
  final String entryId;
  final error;

  FullFeedEntryNotLoadedAction(this.feedId, this.entryId, this.error);

  @override
  String toString() {
    return 'FullFeedEntryLoadedAction{feedId: $feedId, entryId: $entryId, error: $error}';
  }
}

class SetReadStateAction {
  final String feedId;
  final String entryId;
  final bool read;

  SetReadStateAction(this.feedId, this.entryId, this.read);

  @override
  String toString() {
    return 'SetReadStateAction{feedId: $feedId, entryId: $entryId, read: $read}';
  }
}

class SetReadStateStartedAction {
  final String feedId;
  final String entryId;
  final bool read;

  SetReadStateStartedAction(this.feedId, this.entryId, this.read);

  @override
  String toString() {
    return 'SetReadStateStartedAction{feedId: $feedId, entryId: $entryId, read: $read}';
  }
}

class SetReadStateSucceededAction {
  final String feedId;
  final String entryId;
  final bool read;

  SetReadStateSucceededAction(this.feedId, this.entryId, this.read);

  @override
  String toString() {
    return 'SetReadStateSucceededAction{feedId: $feedId, entryId: $entryId, read: $read}';
  }
}

class SetReadStateFailedAction {
  final String feedId;
  final String entryId;
  final error;

  SetReadStateFailedAction(this.feedId, this.entryId, this.error);

  @override
  String toString() {
    return 'SetReadStateFailedAction{feedId: $feedId, entryId: $entryId, error: $error}';
  }
}

class SetStarredStateAction {
  final String feedId;
  final String entryId;
  final bool starred;

  SetStarredStateAction(this.feedId, this.entryId, this.starred);

  @override
  String toString() {
    return 'SetStarredStateAction{feedId: $feedId, entryId: $entryId, starred: $starred}';
  }
}

class SetStarredStateStartedAction {
  final String feedId;
  final String entryId;
  final bool starred;

  SetStarredStateStartedAction(this.feedId, this.entryId, this.starred);

  @override
  String toString() {
    return 'SetStarredStateStartedAction{feedId: $feedId, entryId: $entryId, starred: $starred}';
  }
}

class SetStarredStateSucceededAction {
  final String feedId;
  final String entryId;
  final bool starred;

  SetStarredStateSucceededAction(this.feedId, this.entryId, this.starred);

  @override
  String toString() {
    return 'SetStarredStateSucceededAction{feedId: $feedId, entryId: $entryId, starred: $starred}';
  }
}

class SetStarredStateFailedAction {
  final String feedId;
  final String entryId;
  final error;

  SetStarredStateFailedAction(this.feedId, this.entryId, this.error);

  @override
  String toString() {
    return 'SetStarredStateFailedAction{feedId: $feedId, entryId: $entryId, error: $error}';
  }
}

class UpdateFilterAction {
  final VisibilityFilter newFilter;

  UpdateFilterAction(this.newFilter);

  @override
  String toString() {
    return 'UpdateFilterAction{newFilter: $newFilter}';
  }
}
