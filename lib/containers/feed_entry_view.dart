import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_reader/actions/actions.dart';
import 'package:flutter_reader/models/models.dart';
import 'package:flutter_reader/presentation/feed_entry_screen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class FeedEntryView extends StatelessWidget {
  final String feedId;
  final String entryId;

  FeedEntryView({Key key, @required this.feedId, @required this.entryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: (store) =>
          _ViewModel.fromStore(context, feedId, entryId, store),
      onInit: (store) {
        store.dispatch(new OpenFeedEntryAction(feedId, entryId));
      },
      builder: (context, vm) {
        return new FeedEntryScreen(
          loading: vm.loading,
          feedEntry: vm.feedEntry,
          onReadPressed: vm.onReadPressed,
          onStarredPressed: vm.onStarredPressed,
        );
      },
    );
  }
}

class _ViewModel {
  final bool loading;
  final FeedEntry feedEntry;
  final VoidCallback onReadPressed;
  final VoidCallback onStarredPressed;

  _ViewModel({
    @required this.loading,
    @required this.feedEntry,
    @required this.onReadPressed,
    @required this.onStarredPressed,
  });

  static _ViewModel fromStore(BuildContext context, String feedId,
      String entryId, Store<AppState> store) {
    final entry = store.state.feedEntries[feedId]
        .firstWhere((entry) => entry.id == entryId);
    return new _ViewModel(
        loading: entry.content == null,
        feedEntry: entry,
        onReadPressed: () {
          store.dispatch(new SetReadStateAction(feedId, entryId, !entry.read));
          Navigator.of(context).pop();
        },
        onStarredPressed: () {
          store.dispatch(
              new SetStarredStateAction(feedId, entryId, !entry.starred));
        });
  }
}
