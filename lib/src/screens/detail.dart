import 'dart:async';
import 'package:flutter/material.dart';
import '../blocs/comments_provider.dart';
import '../models/item_model.dart';
import '../widgets/comment.dart';

class Detail extends StatelessWidget {
  final int itemId;

  Detail({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: buildBody(bloc),
    );
  }

  Widget loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    final loader = loading();

    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return loader;
        }
        final itemFuture = snapshot.data[itemId];
        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return loader;
            }

            return buildDetail(snapshot.data, itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildDetail(Map<int, Future<ItemModel>> itemMap, ItemModel item) {
    final children = <Widget>[];
    children.add(buildTitle(item.title));
    children.addAll(buildCommentList(itemMap, item));

    return ListView(
      children: children,
    );
  }

  Widget buildTitle(String title) {
    return Container(
      margin: EdgeInsets.all(8.0),
      alignment: Alignment.topCenter,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  List<Widget> buildCommentList(
      Map<int, Future<ItemModel>> itemMap, ItemModel item) {
    final commentList = item.kids.map((commentId) {
      return Comment(
        itemId: commentId,
        itemMap: itemMap,
        depth: 1,
      );
    }).toList();

    return commentList;
  }
}
