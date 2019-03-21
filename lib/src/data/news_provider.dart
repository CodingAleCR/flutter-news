import 'package:news/src/domain/models/item_model.dart';
import 'dart:async';

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}
