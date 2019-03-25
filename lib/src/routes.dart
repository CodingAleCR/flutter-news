import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/detail_screen.dart';
import 'domain/actions/home_actions.dart';
import 'domain/state.dart';

Route routes(RouteSettings settings) {
  if (settings.name == "/") {
    return MaterialPageRoute(builder: (BuildContext context) {
      return StoreBuilder<AppState>(
        onInit: (store) => store.dispatch(FetchingTopIds()),
        builder: (context, store) => HomeScreen(),
      );
    });
  } else {
     final itemId = int.parse(settings.name.replaceFirst("/", ""));
     return MaterialPageRoute(builder: (BuildContext context) {
      return StoreBuilder<AppState>(
        onInit: (store) => store.dispatch(FetchItem(itemId: itemId)),
        builder: (context, store) => DetailScreen(),
      );
    });
  }
}
