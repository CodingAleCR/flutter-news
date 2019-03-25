import '../state.dart';
import './stories_reducer.dart';
import '../actions/home_actions.dart';

AppState appReducer(AppState state, action) {
  if (action is LoadingContent) {
    return state.copyWith(
      isLoading: true,
    );
  }
  if (action is ClearCache) {
    return AppState.initialState();
  }
  if (action is FetchingTopIdsSuccessful) {
    return state.copyWith(
      topIds: action.topIds,
    );
  }
  if (action is FetchingItemsSuccessful) {
    return state.copyWith(
      items: action.items,
      isLoading: false,
    );
  }
  if (action is FetchItem) {
    return state.copyWith(
      comments: {},
    );
  }
  if (action is FetchItemSuccessful) {
    return state.copyWith(
      item: action.item,
      isLoading: false,
    );
  }
  if (action is CommentFetchedSuccessfully) {
    final comments = state.comments;
    comments[action.comment.id] = action.comment;
    return state.copyWith(
      comments: comments,
    );
  }

  return state;
}
