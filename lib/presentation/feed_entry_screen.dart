import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader/models/models.dart';
import 'package:flutter_reader/presentation/loading_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedEntryScreen extends StatelessWidget {
  final bool loading;
  final FeedEntry feedEntry;
  final VoidCallback onReadPressed;
  final VoidCallback onStarredPressed;

  FeedEntryScreen({
    Key key,
    @required this.loading,
    @required this.feedEntry,
    @required this.onReadPressed,
    @required this.onStarredPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final parentTheme = Theme.of(context);
    return new Theme(
      data: parentTheme.copyWith(
          scaffoldBackgroundColor: parentTheme.canvasColor),
      child: new Scaffold(
          floatingActionButton: new FloatingActionButton(
              child: const Icon(Icons.open_in_new),
              onPressed: () {
                launch(feedEntry.url);
              }),
          appBar: new AppBar(
            title: loading
                ? null
                : new Text(feedEntry.title, overflow: TextOverflow.ellipsis),
            actions: loading
                ? null
                : <Widget>[
                    new IconButton(
                        icon: new Icon(Icons.mail),
                        onPressed: feedEntry.readStateTransitioning
                            ? null
                            : onReadPressed)
                  ],
          ),
          body: loading ? new LoadingIndicator() : _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return new SingleChildScrollView(
      child: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Expanded(
                      child: new Text(feedEntry.title.trim(),
                          style: Theme.of(context).textTheme.title),
                    ),
                    new IconButton(
                        icon: new Icon(
                            feedEntry.starred ? Icons.star : Icons.star_border,
                            color: feedEntry.starred
                                ? Colors.yellow
                                : Colors.black45),
                        onPressed: feedEntry.starredStateTransitioning
                            ? null
                            : onStarredPressed)
                  ],
                ),
                margin: const EdgeInsets.only(bottom: 24.0)),
            new Text(feedEntry.content,
                style: Theme.of(context).textTheme.body1),
            // White space to prevent the 'open' button from hiding the bottom
            // of the text.
            new SizedBox(height: 70.0),
          ],
        ),
      ),
    );
  }
}
