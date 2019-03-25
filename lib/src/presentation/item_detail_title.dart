import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:news/src/domain/state.dart';
import 'package:news/src/domain/models/item_model.dart';

class ItemDetailTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        var title;
        if (vm.isLoading) {
          title = "Story Detail";
        } else {
          title = vm.item.title;
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Hacker News",
              style: TextStyle(
                color: Colors.orange[800],
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.orange[800],
              ),
            )
          ],
        );
      },
    );
  }
}

class _ViewModel {
  final ItemModel item;
  final bool isLoading;

  _ViewModel({@required this.item, @required this.isLoading});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      item: store.state.item,
      isLoading: store.state.isLoading,
    );
  }
}
