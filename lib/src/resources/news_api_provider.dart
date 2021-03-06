import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' show Client;
import 'news_provider.dart';
import '../models/item_model.dart';

final _baseUrl = "https://hacker-news.firebaseio.com/v0";

class NewsAPIProvider implements Source {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get("$_baseUrl/topstories.json");
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get("$_baseUrl/item/$id.json");
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJSON(parsedJson);
  }
}
