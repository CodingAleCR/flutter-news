import 'package:redux/redux.dart';
import 'package:news/src/data/repository.dart';
import '../actions/home_actions.dart';
import '../state.dart';
import '../models/item_model.dart';

List<Middleware<AppState>> createStoriesMiddleware() => [
      TypedMiddleware<AppState, FetchingTopIds>(_fetchTopIds()),
      TypedMiddleware<AppState, FetchingTopIdsSuccessful>(_fetchItems()),
      TypedMiddleware<AppState, ClearCache>(_clearCache()),
      TypedMiddleware<AppState, FetchItem>(_fetchItem()),
      TypedMiddleware<AppState, FetchItemComments>(_fetchItemComments()),
    ];

Middleware<AppState> _fetchTopIds() {
  return (Store store, action, NextDispatcher next) async {
    if (action is FetchingTopIds) {
      store.dispatch(LoadingContent());
      try {
        final Repository repository = Repository();
        List<int> list = await repository.fetchTopIds();
        store.dispatch(FetchingTopIdsSuccessful(topIds: list));
      } catch (error) {
        store.dispatch(Error(message: "Error While Fetching top ids."));
      }
    }

    // After you do whatever logic you need to do,
    // call this Redux built-in method,
    // It continues the redux cycle.
    next(action);
  };
}

Middleware<AppState> _fetchItems() {
  return (Store store, action, NextDispatcher next) async {
    if (action is FetchingTopIdsSuccessful) {
      try {
        final Repository repository = Repository();
        final List<ItemModel> items = [];
        for (var itemId in action.topIds) {
          ItemModel item = await repository.fetchItem(itemId);
          items.add(item);
        }

        store.dispatch(FetchingItemsSuccessful(items: items));
      } catch (error) {
        store.dispatch(Error(message: "Error while items."));
      }
    }

    next(action);
  };
}

Middleware<AppState> _clearCache() {
  return (Store store, action, NextDispatcher next) async {
    if (action is ClearCache) {
      try {
        final Repository repository = Repository();
        await repository.clearCache();
        store.dispatch(FetchingTopIds());
      } catch (error) {
        store.dispatch(Error(message: "Error while items."));
      }
    }

    next(action);
  };
}

Middleware<AppState> _fetchItem() {
  return (Store store, action, NextDispatcher next) async {
    if (action is FetchItem) {
      store.dispatch(LoadingContent());
      try {
        final Repository repository = Repository();
        ItemModel item = await repository.fetchItem(action.itemId);
        store.dispatch(FetchItemComments(item: item));
      } catch (error) {
        store.dispatch(
            Error(message: "Error While Fetching item and its details."));
      }
    }

    // After you do whatever logic you need to do,
    // call this Redux built-in method,
    // It continues the redux cycle.
    next(action);
  };
}

Middleware<AppState> _fetchItemComments() {
  return (Store store, action, NextDispatcher next) async {
    if (action is FetchItemComments) {
      final item = action.item;
      try {
        final Repository repository = Repository();
        Map<int, ItemModel> comments = {};
        item.kids.forEach((kidId) {
          repository.fetchItem(kidId).then((kid) {
            comments[kidId] = kid;
            store.dispatch(CommentFetchedSuccessfully(comment: kid));
          });
        });
        store.dispatch(FetchItemSuccessful(item: item));
      } catch (error) {
        store.dispatch(
            Error(message: "Error While Fetching item and its details."));
      }
    }

    // After you do whatever logic you need to do,
    // call this Redux built-in method,
    // It continues the redux cycle.
    next(action);
  };
}
