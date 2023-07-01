import 'package:built_collection/built_collection.dart';
import 'package:flutter_reader/actions/actions.dart';
import 'package:flutter_reader/models/models.dart';
import 'package:redux/redux.dart';

final feedEntriesReducer =
    combineReducers<BuiltListMultimap<String, FeedEntry>>([
  new TypedReducer<BuiltListMultimap<String, FeedEntry>,
      FeedEntriesLoadedAction>(_setLoadedFeedEntries),
  new TypedReducer<BuiltListMultimap<String, FeedEntry>,
      MoreFeedEntriesLoadedAction>(_addLoadedFeedEntries),
  new TypedReducer<BuiltListMultimap<String, FeedEntry>,
      FeedEntriesNotLoadedAction>(_keepOldFeedEntries),
  new TypedReducer<BuiltListMultimap<String, FeedEntry>,
      FullFeedEntryLoadedAction>(_setFeedEntryContent),
  new TypedReducer<BuiltListMultimap<String, FeedEntry>,
      SetReadStateSucceededAction>(_setFeedEntryReadState),
  new TypedReducer<BuiltListMultimap<String, FeedEntry>,
      SetReadStateStartedAction>(_setReadStateStarted),
  new TypedReducer<BuiltListMultimap<String, FeedEntry>,
      SetStarredStateSucceededAction>(_setFeedEntryStarredState),
  new TypedReducer<BuiltListMultimap<String, FeedEntry>,
      SetStarredStateStartedAction>(_setStarredStateStarted),
]);

BuiltListMultimap<String, FeedEntry> _setLoadedFeedEntries(
    BuiltListMultimap<String, FeedEntry> feedEntries,
    FeedEntriesLoadedAction action) {
  return (feedEntries.toBuilder()
        ..removeAll(action.feedId)
        ..addValues(action.feedId, action.feedEntries))
      .build();
}

BuiltListMultimap<String, FeedEntry> _addLoadedFeedEntries(
    BuiltListMultimap<String, FeedEntry> feedEntries,
    MoreFeedEntriesLoadedAction action) {
  return (feedEntries.toBuilder()..addValues(action.feedId, action.feedEntries))
      .build();
}

BuiltListMultimap<String, FeedEntry> _keepOldFeedEntries(
    BuiltListMultimap<String, FeedEntry> feedEntries,
    FeedEntriesNotLoadedAction action) {
  return feedEntries;
}

BuiltListMultimap<String, FeedEntry> _modifyEntry(
    BuiltListMultimap<String, FeedEntry> entryMap,
    String feedId,
    String entryId,
    FeedEntry f(FeedEntry entry)) {
  final entries = entryMap[feedId];
  final modifiedEntries =
      entries.map((entry) => entry.id == entryId ? f(entry) : entry);
  return (entryMap.toBuilder()
        ..removeAll(feedId)
        ..addValues(feedId, modifiedEntries))
      .build();
}

BuiltListMultimap<String, FeedEntry> _setFeedEntryContent(
    BuiltListMultimap<String, FeedEntry> state,
    FullFeedEntryLoadedAction action) {
  return _modifyEntry(state, action.feedEntry.feedId, action.feedEntry.id,
      (_) => action.feedEntry);
}

BuiltListMultimap<String, FeedEntry> _setFeedEntryReadState(
    BuiltListMultimap<String, FeedEntry> state,
    SetReadStateSucceededAction action) {
  // We set readStateTransitioning to false because we assume there cannot be
  // more than one setReadState request in flight (the UI should forbid it)
  return _modifyEntry(state, action.feedId, action.entryId,
      (entry) => entry.copy(read: action.read, readStateTransitioning: false));
}

BuiltListMultimap<String, FeedEntry> _setReadStateStarted(
    BuiltListMultimap<String, FeedEntry> state,
    SetReadStateStartedAction action) {
  return _modifyEntry(state, action.feedId, action.entryId,
      (entry) => entry.copy(readStateTransitioning: true));
}

BuiltListMultimap<String, FeedEntry> _setFeedEntryStarredState(
    BuiltListMultimap<String, FeedEntry> state,
    SetStarredStateSucceededAction action) {
  // We set starredStateTransitioning to false because we assume there cannot be
  // more than one setStarredState request in flight (the UI should forbid it)
  return _modifyEntry(
      state,
      action.feedId,
      action.entryId,
      (entry) => entry.copy(
          starred: action.starred, starredStateTransitioning: false));
}

BuiltListMultimap<String, FeedEntry> _setStarredStateStarted(
    BuiltListMultimap<String, FeedEntry> state,
    SetStarredStateStartedAction action) {
  return _modifyEntry(state, action.feedId, action.entryId,
      (entry) => entry.copy(starredStateTransitioning: true));
}
