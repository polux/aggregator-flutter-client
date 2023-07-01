import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:meta/meta.dart';

/// A [RefreshIndicator] whose refresh state can be set declaratively instead
/// of via calls to [show].
class DeclarativeRefreshIndicator extends StatefulWidget {
  final bool isRefreshing;
  final Widget child;
  final VoidCallback onRefresh;

  DeclarativeRefreshIndicator(
      {@required this.isRefreshing,
      @required this.child,
      @required this.onRefresh});

  @override
  State<StatefulWidget> createState() {
    return new DeclarativeRefreshIndicatorState();
  }
}

class DeclarativeRefreshIndicatorState
    extends State<DeclarativeRefreshIndicator> {
  Completer<Null> _completer;
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    if (widget.isRefreshing) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _completer = new Completer();
        _refreshKey.currentState.show();
      });
    }
  }

  @override
  void didUpdateWidget(DeclarativeRefreshIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isRefreshing != widget.isRefreshing) {
      if (widget.isRefreshing == true) {
        if (_completer == null) {
          _completer = new Completer();
        }
        _refreshKey.currentState.show();
      } else {
        _completer.complete();
        _completer = null;
      }
    }
  }

  Future<Null> _onRefresh() {
    if (_completer == null) {
      // this is a user-initiated refresh
      _completer = new Completer();
      widget.onRefresh();
    }
    return _completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
        key: _refreshKey, child: widget.child, onRefresh: _onRefresh);
  }
}
