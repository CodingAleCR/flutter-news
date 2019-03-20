import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'package:news/src/resources/news_api_provider.dart';

main() {
  test('fetchTopIds returns a list of IDs.', () async {
    // Arrange
    final newsApi = NewsAPIProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    // Act
    final ids = await newsApi.fetchTopIds();

    // Assert
    expect(ids, [1, 2, 3, 4]);
  });

  test('fetchItem returns an ItemModel instance', () async {
    // Arrange
    final newsApi = NewsAPIProvider();
    final mockResponse = {'id': 123};
    newsApi.client = MockClient((request) async {
      return Response(json.encode(mockResponse), 200);
    });

    // Act
    final item = await newsApi.fetchItem(123);

    // Assert
    expect(item.id, 123);
  });
}
