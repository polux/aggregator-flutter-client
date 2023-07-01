import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader/containers/feed_entry_view.dart';
import 'package:flutter_reader/models/models.dart';
import 'package:flutter_reader/presentation/declarative_refresh_indicator.dart';
import 'package:flutter_reader/presentation/feed_entry_item.dart';
import 'package:flutter_reader/presentation/keys.dart';

typedef void EntryCallback(FeedEntry entryId);

class FeedScreen extends StatefulWidget {
  final bool loading;
  final bool loadingMore;
  final String feedId;
  final String feedTitle;
  final BuiltList<FeedEntry> feedEntries;
  final VoidCallback onRefresh;
  final VoidCallback onScrollToBottom;
  final EntryCallback onStarredPressed;

  FeedScreen({
    Key key,
    @required this.loading,
    @required this.loadingMore,
    @required this.feedId,
    @required this.feedTitle,
    @required this.feedEntries,
    @required this.onRefresh,
    @required this.onScrollToBottom,
    @required this.onStarredPressed,
  }) : super(key: key);

  @override
  State<FeedScreen> createState() {
    return new FeedScreenState();
  }
}

class FeedScreenState extends State<FeedScreen> {
  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        widget.onScrollToBottom();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.feedTitle, overflow: TextOverflow.ellipsis),
      ),
      body: _buildListView(),
    );
  }

  Widget _buildListView() {
    return new DeclarativeRefreshIndicator(
        isRefreshing: widget.loading,
        onRefresh: widget.onRefresh,
        child: new ListView.builder(
          key: ReaderKeys.feedEntriesList,
          itemExtent: 72.0,
          itemCount: widget.feedEntries.length + 1,
          controller: scrollController,
          itemBuilder: (BuildContext context, int index) {
            if (index == widget.feedEntries.length) {
              return new CustomPaint(
                  painter: new _ShadowPainter(),
                  child: new Container(
                    height: 72.0,
                    child: widget.loadingMore
                        ? new Center(
                            child: new CircularProgressIndicator(),
                          )
                        : null,
                  ));
            } else {
              final feedEntry = widget.feedEntries[index];
              return new FeedEntryItem(
                feedEntry: feedEntry,
                onTap: () => _onFeedEntryTapped(context, feedEntry),
                onStarredPressed: () => widget.onStarredPressed(feedEntry),
              );
            }
          },
        ));
  }

  void _onFeedEntryTapped(BuildContext context, FeedEntry feedEntry) {
    Navigator.of(context).push(new MaterialPageRoute(
          builder: (_) => new FeedEntryView(
              feedId: feedEntry.feedId, entryId: feedEntry.id),
        ));
  }
}

class _ShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..color = Colors.black
      ..maskFilter = new MaskFilter.blur(BlurStyle.normal, 1.0);
    final path = new Path()
      ..addPolygon([Offset.zero, new Offset(size.width, 0.0)], false);
    canvas.clipRect(Offset.zero & size);
    canvas.drawLine(
        size.topLeft(Offset.zero), size.topRight(Offset.zero), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
