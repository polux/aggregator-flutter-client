import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader/containers/feed_view.dart';
import 'package:flutter_reader/models/models.dart';
import 'package:flutter_reader/presentation/declarative_refresh_indicator.dart';
import 'package:flutter_reader/presentation/feed_info_item.dart';
import 'package:flutter_reader/presentation/keys.dart';
// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

class FeedInfosList extends StatelessWidget {
  final bool loading;
  final BuiltList<FeedInfo> feedInfos;
  final VoidCallback onRefresh;

  FeedInfosList({
    Key key,
    @required this.loading,
    @required this.feedInfos,
    @required this.onRefresh,
  }) : super(key: key);

//  @override
//  Widget build(BuildContext context) {
//    return new AppLoading(builder: (context, loading) {
//      return loading
//          ? new LoadingIndicator(key: ReaderKeys.feedInfosLoading)
//          : _buildListView();
//    });
//  }
  @override
  Widget build(BuildContext context) {
    return new DeclarativeRefreshIndicator(
        //onRefresh: onRefresh,
        isRefreshing: loading,
        onRefresh: onRefresh,
        child: new ListView.builder(
          key: ReaderKeys.feedInfosList,
          itemExtent: 56.0,
          itemCount: feedInfos.length,
          itemBuilder: (BuildContext context, int index) {
            final feedInfo = feedInfos[index];
            return new FeedInfoItem(
              feedInfo: feedInfo,
              onTap: () => _onFeedInfoTap(context, feedInfo),
            );
          },
        ));
  }

  void _onFeedInfoTap(BuildContext context, FeedInfo feedInfo) {
    Navigator.of(context).push(new MaterialPageRoute(
          builder: (_) => new FeedView(feedId: feedInfo.id),
        ));
  }
}
