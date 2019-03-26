import 'comments_bloc.dart';
import 'stories_bloc.dart';
export 'comments_bloc.dart';
export 'stories_bloc.dart';

class AppBloc {
  final CommentsBloc commentsBloc;
  final StoriesBloc storiesBloc;

  AppBloc({this.commentsBloc, this.storiesBloc});
}
