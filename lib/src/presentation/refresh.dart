import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:news/src/domain/state.dart';
import 'package:news/src/domain/actions/home_actions.dart';

class RefreshStoryList extends StatelessWidget {
  final Widget child;

  RefreshStoryList({this.child});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (Store<AppState> store) {
        return () async {
          final action = ClearCache();
          store.dispatch(action);
          return action.completer;
        };
      },
      builder: (BuildContext context, VoidCallback clearCache) {
        return RefreshIndicator(
          child: child,
          onRefresh: clearCache,
        );
      },
    );
  }
}