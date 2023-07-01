import 'package:built_collection/built_collection.dart';
import 'package:flutter_reader/actions/actions.dart';
import 'package:flutter_reader/models/models.dart';
import 'package:redux/redux.dart';

final fullFeedEntriesReducer = combineReducers<BuiltMap<String, FeedEntry>>([
  new TypedReducer<BuiltMap<String, FeedEntry>, FullFeedEntryLoadedAction>(
      _setLoadedFeedEntry),
  new TypedReducer<BuiltMap<String, FeedEntry>, FullFeedEntryNotLoadedAction>(
      _keepOldFeedEntry),
]);

BuiltMap<String, FeedEntry> _setLoadedFeedEntry(
    BuiltMap<String, FeedEntry> fullFeedEntries,
    FullFeedEntryLoadedAction action) {
  return (fullFeedEntries.toBuilder()..[action.feedEntry.id] = action.feedEntry)
      .build();
}

BuiltMap<String, FeedEntry> _keepOldFeedEntry(
    BuiltMap<String, FeedEntry> feedEntries,
    FullFeedEntryNotLoadedAction action) {
  return feedEntries;
}
