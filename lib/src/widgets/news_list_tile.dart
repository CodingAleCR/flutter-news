import 'dart:async';
import 'package:flutter/material.dart';
import 'loading_tile.dart';
import '../models/item_model.dart';
import '../blocs/app_provider.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = AppProvider.storiesBlocOf(context);
    final loadingTile = LoadingTile();
    return StreamBuilder(
      stream: bloc.items,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return loadingTile;
        }
        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return loadingTile;
            }
            return buildTile(context, itemSnapshot.data);
          },
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
