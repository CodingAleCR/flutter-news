import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import 'package:news/src/data/repository.dart';

class CommentsBloc {
  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  //Streams
  Observable<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;

  //Sinks
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    // Applying the transformer to the fetcher, and then piping it to the output so that 
    // it does not overuse the transformer.
    _commentsFetcher.transform(_commentsTransformer()).pipe(_commentsOutput);
  }

  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      //The third parameter is an index useful telling how many times the transformer gets called.
      (cache, int id, _) {
        cache[id] = _repository.fetchItem(id);
        // ** Recursive call for fetching the comments tree **
        cache[id].then((ItemModel item) {
          item.kids.forEach((kidId) => fetchItemWithComments(kidId));
        });
        // ** End of recursive call **
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
