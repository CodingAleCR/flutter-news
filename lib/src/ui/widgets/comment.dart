import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news/src/domain/models/item_model.dart';
import '../widgets/loading_tile.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingTile();
        }

        final children = <Widget>[
          buildComment(snapshot.data),
          Divider(),
        ];
        snapshot.data.kids.forEach((commentId) {
          children.add(
            Comment(
              itemId: commentId,
              itemMap: itemMap,
              depth: depth + 1,
            ),
          );
        });

        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildComment(ItemModel comment) {
    final text = buildText(comment.text);

    return ListTile(
      title: Text(text),
      subtitle: comment.by == "" ? Text("Deleted") : Text(comment.by),
      contentPadding: EdgeInsets.only(
        left: 16.0 * depth,
        right: 16.0,
      ),
    );
  }

  buildText(String text) {
    return text
        .replaceAll('&#x27;', "'")
        .replaceAll("<p>", "\n\n")
        .replaceAll("</p>", "")
        .replaceAll("&quot;", "\"\"");
  }
}
