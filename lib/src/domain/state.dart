import 'models/item_model.dart';

class AppState {
  final bool isLoading;
  final List<int> topIds;
  final List<ItemModel> items;
  final ItemModel item;
  final Map<int, ItemModel> comments;

  AppState({this.topIds, this.items, this.isLoading, this.item, this.comments});

  AppState copyWith({bool isLoading, List<int> topIds, List<ItemModel> items, ItemModel item, Map<int, ItemModel> comments}) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      topIds: topIds ?? this.topIds,
      items: items ?? this.items,
      item: item ?? this.item,
      comments: comments?? this.comments,
    );
  }

  @override
  String toString() {
    return 'AppState{ Item: {$item}, Comments: {$comments}}';
  }

  AppState.initialState()
      : topIds = List.unmodifiable(<int>[]),
        items = List.unmodifiable(<ItemModel>[]),
        isLoading = true,
        item = null,
        comments = {};
}
