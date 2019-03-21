import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import 'news_provider.dart';

import 'package:news/src/domain/models/item_model.dart';

class Repository {
  List<Source> sources = <Source>[
    newsDbProvider,
    NewsAPIProvider(),
  ];
  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() async {
    List<int> ids;
    for (var source in sources) {
      ids = await source.fetchTopIds();
      if (ids != null) {
        break;
      }
    }
    return ids;
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    for (var source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }
    for (var cache in caches) {
      cache.addItem(item);
    }
    return item;
  }

  Future clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }
}
