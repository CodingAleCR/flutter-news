import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/detail.dart';
import 'blocs/stories_provider.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: "Hacker News",
          theme: ThemeData.dark(),
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    /* EXAMPLE:  If you push the PassArguments route
    if (settings.name == PassArgumentsScreen.routeName) {
      // Cast the arguments to the correct type: ScreenArguments.
      final ScreenArguments args = settings.arguments;

      // Then, extract the required data from the arguments and
      // pass the data to the correct screen.
      return MaterialPageRoute(
        builder: (context) {
          return PassArgumentsScreen(
            title: args.title,
            message: args.message,
          );
        },
      ); */

    if (settings.name == "/") {
      return MaterialPageRoute(builder: (context) {
        //Data initalization or extraction goes in here.
        final storyBloc = StoriesProvider.of(context);
        storyBloc.fetchTopIds();
        return Home();
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        //Data initalization or extraction goes in here.
        final commentsBloc = CommentsProvider.of(context);
        final itemId = int.parse(settings.name.replaceFirst("/", ""));

        commentsBloc.fetchItemWithComments(itemId);

        return Detail(
          itemId: itemId,
        );
      });
    }
  }
}
