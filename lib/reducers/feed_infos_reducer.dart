import 'package:built_collection/built_collection.dart';
import 'package:flutter_reader/actions/actions.dart';
import 'package:flutter_reader/models/models.dart';
import 'package:redux/redux.dart';

final feedInfosReducer = combineReducers<BuiltList<FeedInfo>>([
  new TypedReducer<BuiltList<FeedInfo>, FeedInfosLoadedAction>(
      _setLoadedFeedInfos),
  new TypedReducer<BuiltList<FeedInfo>, FeedInfosNotLoadedAction>(
      _keepOldFeedInfos),
  new TypedReducer<BuiltList<FeedInfo>, SetReadStateSucceededAction>(
      _updateReadCount),
]);

BuiltList<FeedInfo> _setLoadedFeedInfos(
    BuiltList<FeedInfo> feedInfos, FeedInfosLoadedAction action) {
  return action.feedInfos;
}

BuiltList<FeedInfo> _keepOldFeedInfos(
    BuiltList<FeedInfo> feedInfos, FeedInfosNotLoadedAction action) {
  return feedInfos;
}

BuiltList<FeedInfo> _updateReadCount(
    BuiltList<FeedInfo> feedInfos, SetReadStateSucceededAction action) {
  // We assume that SetReadStateStartedAction was only issued when the source
  // state was different from the target state.
  return (feedInfos.toBuilder()
        ..map((feedInfo) => feedInfo.id == action.feedId
            ? feedInfo.copy(
                unreadCount: action.read
                    ? feedInfo.unreadCount - 1
                    : feedInfo.unreadCount + 1)
            : feedInfo))
      .build();
}
