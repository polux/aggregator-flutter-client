// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader/models/models.dart';
import 'package:flutter_reader/presentation/keys.dart';

class FeedEntryItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final VoidCallback onStarredPressed;
  final FeedEntry feedEntry;
  final bool enabled;
  final bool selected;
  final GestureLongPressCallback onLongPress;

  FeedEntryItem({
    @required this.onTap,
    @required this.onStarredPressed,
    @required this.feedEntry,
    this.enabled = true,
    this.selected = false,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final unread = !feedEntry.read;
    final theme = Theme.of(context);
    final subhead = theme.textTheme.subhead;
    final titleTextStyle =
        unread ? subhead : subhead.copyWith(color: theme.disabledColor);
    final iconColor = unread ? Colors.black45 : theme.disabledColor;

    final Decoration decoration = new BoxDecoration(
        border: new Border(bottom: Divider.createBorderSide(context)));

    return new DecoratedBox(
      position: DecorationPosition.foreground,
      decoration: decoration,
      child: _buildCustomTile(context,
          title: new Text(feedEntry.title,
              key: ReaderKeys.feedEntryItemTitle(feedEntry.id),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: titleTextStyle),
          trailing: new IconButton(
              icon: new Icon(feedEntry.starred ? Icons.star : Icons.star_border,
                  color: iconColor),
              onPressed: feedEntry.starredStateTransitioning
                  ? null
                  : onStarredPressed)),
    );
  }

  Widget _buildCustomTile(BuildContext context,
      {@required Widget title, @required Widget trailing}) {
    return new InkWell(
      onTap: enabled ? onTap : null,
      onLongPress: enabled ? onLongPress : null,
      child: new Container(
        color: Theme.of(context).canvasColor,
        child: new Semantics(
          selected: selected,
          enabled: enabled,
          child: new ConstrainedBox(
              constraints: new BoxConstraints(minHeight: 72.0),
              child: new Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: new UnconstrainedBox(
                  constrainedAxis: Axis.horizontal,
                  child: new SafeArea(
                    top: false,
                    bottom: false,
                    child: new Row(children: <Widget>[
                      new Expanded(child: title),
                      new Container(
                        margin: const EdgeInsetsDirectional.only(start: 16.0),
                        alignment: AlignmentDirectional.centerEnd,
                        child: trailing,
                      )
                    ]),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

//
