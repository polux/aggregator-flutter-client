// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader/models/models.dart';
import 'package:flutter_reader/presentation/keys.dart';
import 'package:flutter_reader/presentation/theme.dart';

class FeedInfoItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final FeedInfo feedInfo;

  FeedInfoItem({
    @required this.onTap,
    @required this.feedInfo,
  });

  @override
  Widget build(BuildContext context) {
    final unread = feedInfo.unreadCount > 0;
    final theme = Theme.of(context);
    final subhead = theme.textTheme.subhead;
    final caption = theme.textTheme.caption;
    final countTextStyle =
        unread ? caption : caption.copyWith(color: theme.disabledColor);
    final titleTextStyle =
        unread ? subhead : subhead.copyWith(color: theme.disabledColor);
    final iconColor = unread ? theme.iconTheme.color : theme.disabledColor;
    return new Container(
      color: ReaderTheme.theme.canvasColor,
      child: new ListTile(
          key: ReaderKeys.feedInfoItem(feedInfo.id),
          onTap: onTap,
          leading: new Icon(Icons.folder, color: iconColor),
          title: new Text(feedInfo.title,
              key: ReaderKeys.feedInfoItemTitle(feedInfo.id),
              style: titleTextStyle),
          trailing: new Text(
            feedInfo.unreadCount.toString(),
            key: ReaderKeys.feedInfoItemUnreadCount(feedInfo.id),
            style: countTextStyle,
          )),
    );
  }
}

//
