import 'dart:async';
import 'package:flutter/material.dart';
import 'loading_tile.dart';
import 'package:news/src/domain/models/item_model.dart';
import 'package:news/src/domain/bloc/stories_provider.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
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

  Widget buildTile(BuildContext context, ItemModel item) {
    return Card(
      margin: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
      child: ListTile(
        title: Text(item.title),
        subtitle: Text("${item.score} votes"),
        trailing: Column(
          children: <Widget>[Icon(Icons.comment), Text("${item.descendants}")],
        ),
        onTap: () {
          Navigator.pushNamed(context, "/${item.id}");
        },
      ),
    );
  }
}
