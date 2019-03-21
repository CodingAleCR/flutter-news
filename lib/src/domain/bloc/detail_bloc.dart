import 'package:news/src/data/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'package:news/src/domain/models/item_model.dart';

enum DetailEvents {
  ComponentInitialized,
  FetchItemWithComments,
}

abstract class DetailState {}

class ItemUninitialized extends DetailState {
  @override
  String toString() => 'ItemUninitialized';
}

class ItemsError extends DetailState {
  @override
  String toString() => 'ItemsError';
}

class ItemCommentsLoaded extends DetailState {
  @override
  String toString() => 'ItemCommentsLoaded';
}

class DetailBloc extends Bloc<DetailEvents, DetailState> {
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final Repository repository;

  DetailBloc({this.repository});

  @override
  get initialState => ItemUninitialized();

  @override
  Stream<DetailState> mapEventToState(
      DetailState currentState, DetailEvents event) async* {
    try {
      if (event == DetailEvents.FetchItemWithComments) {}
    } catch (_) {
      yield ItemsError();
    }
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
