import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';

import 'routes.dart';
import './domain/state.dart';
import './domain/reducers/reducer.dart';
import './domain/middleware/stories_middleware.dart';

class App extends StatelessWidget {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initialState(),
    middleware: []
      ..addAll(createStoriesMiddleware())
      ..add(LoggingMiddleware.printer()),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: "Hacker News",
        onGenerateRoute: routes,
      ),
    );
  }
}
