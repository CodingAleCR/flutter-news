import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:news/src/domain/state.dart';
import 'package:news/src/domain/models/item_model.dart';
import 'package:news/src/presentation/widgets/loading_tile.dart';

class ItemDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        if (vm.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Container(
          color: Colors.white,
          child: buildComments(vm.item, vm.comments),
        );
      },
    );
  }

  Widget buildComments(ItemModel item, Map<int, ItemModel> comments) {
    return ListView.builder(
      itemCount: item.kids.length,
      itemBuilder: (BuildContext context, int index) {
        final comment = comments[item.kids[index]];
        if (comment != null) {
          return ListTile(
            title: Text(comment.text),
          );
        } else {
          return LoadingTile();
        }
      },
    );
  }
}

class _ViewModel {
  final ItemModel item;
  final Map<int, ItemModel> comments;
  final bool isLoading;

  _ViewModel({@required this.item, this.comments, @required this.isLoading});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      item: store.state.item,
      isLoading: store.state.isLoading,
      comments: store.state.comments,
    );
  }
}
