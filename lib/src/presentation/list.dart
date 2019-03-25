import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:news/src/domain/state.dart';
import 'package:news/src/domain/models/item_model.dart';
import './refresh.dart';

class StoryList extends StatelessWidget {
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

        return RefreshStoryList(
          child: ListView.builder(
            itemCount: vm.items.length,
            itemBuilder: (context, int index) {
              final item = vm.items[index];
              return buildTile(context, item);
            },
          ),
        );
      },
    );
  }

  buildTile(BuildContext context,ItemModel item) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(item.title),
          subtitle: Text("${item.score} votes"),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text("${item.descendants}")
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, "/${item.id}");
          },
        ),
        Divider(),
      ],
    );
  }
}

class _ViewModel {
  // It should take in whatever it is you want to 'watch'
  final List<int> topIds;
  final List<ItemModel> items;
  final bool isLoading;

  _ViewModel({@required this.topIds, @required this.items, @required this.isLoading});

  // This is simply a constructor method.
  // This creates a new instance of this _viewModel
  // with the proper data from the Store.
  //
  // This is a very simple example, but it lets our
  // actual counter widget do things like call 'vm.count'
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      topIds: store.state.topIds,
      items: store.state.items,
      isLoading: store.state.isLoading,
    );
  }
}
