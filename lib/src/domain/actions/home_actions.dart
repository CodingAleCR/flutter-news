import 'dart:async';

import '../models/item_model.dart';

class LoadingContent {}

class FetchingTopIds {}

class FetchingTopIdsSuccessful {
  final List<int> topIds;

  FetchingTopIdsSuccessful({this.topIds});
}

class FetchingItemsSuccessful {
  final List<ItemModel> items;

  FetchingItemsSuccessful({this.items});
}

class FetchItem {
  final int itemId;

  FetchItem({this.itemId});

  @override
  String toString() {
    return "FetchItem{itemId: $itemId}";
  }
}

class FetchItemSuccessful {
  final ItemModel item;

  FetchItemSuccessful({this.item});

  @override
  String toString() {
    return "FetchItemSuccessful{item: $item}";
  }
}

class FetchItemComments {
  final ItemModel item;

  FetchItemComments({this.item});

  @override
  String toString() {
    return "FetchItemComments{item: $item}";
  }
}

class CommentFetchedSuccessfully {
  final ItemModel comment;

  CommentFetchedSuccessfully({this.comment});

  @override
  String toString() {
    return "CommentFetchedSuccessfully{comment: $comment}";
  }
}

class ClearCache {
  final Completer completer;

  ClearCache({this.completer});
}

class Error {
  final String message;

  Error({this.message});
}
