import 'package:flutter/material.dart';
import 'app_bloc.dart';
export 'app_bloc.dart';

class AppProvider extends InheritedWidget {
  final AppBloc bloc;

  AppProvider({Key key, Widget child})
      : bloc = AppBloc(
        commentsBloc: CommentsBloc(),
        storiesBloc: StoriesBloc()
      ),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static AppBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AppProvider)
            as AppProvider)
        .bloc;
  }

  static CommentsBloc commentsBlocOf(BuildContext context) {
    return of(context).commentsBloc;
  }

  static StoriesBloc storiesBlocOf(BuildContext context) {
    return of(context).storiesBloc;
  }
}
