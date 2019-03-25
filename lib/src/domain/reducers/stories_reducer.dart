import 'package:redux/redux.dart';
import '../actions/home_actions.dart';
import 'package:news/src/domain/models/item_model.dart';

final topIdsReducer = combineReducers<List<int>>(
  [
    TypedReducer<List<int>, FetchingTopIdsSuccessful>(_topIds),
  ],
);

List<int> _topIds(List<int> ids, FetchingTopIdsSuccessful action) {
  return action.topIds;
}

final itemsReducer = combineReducers<List<ItemModel>>(
  [
    TypedReducer<List<ItemModel>, FetchingItemsSuccessful>(_items),
  ],
);

List<ItemModel> _items(List<ItemModel> items, FetchingItemsSuccessful action) {
  return action.items;
}
