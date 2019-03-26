import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/detail.dart';
import 'blocs/app_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppProvider(
      child: MaterialApp(
        title: "Hacker News",
        onGenerateRoute: routes,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == "/") {
      return MaterialPageRoute(builder: (context) {
        //Data initalization or extraction goes in here.
        final storiesBloc = AppProvider.of(context).storiesBloc;
        storiesBloc.fetchTopIds();
        return Home();
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        //Data initalization or extraction goes in here.
        final commentsBloc = AppProvider.of(context).commentsBloc;
        final itemId = int.parse(settings.name.replaceFirst("/", ""));

        commentsBloc.fetchItemWithComments(itemId);

        return Detail(
          itemId: itemId,
        );
      });
    }
  }
}
