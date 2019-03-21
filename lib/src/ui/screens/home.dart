import 'package:flutter/material.dart';
import 'package:news/src/domain/bloc/stories_provider.dart';
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    //Don't do this, this is baaad!!! If the call ends up rebuilding the complete widget we would
    //end up with an infinite loop. The ideal place to do this is with the navigation.
    // bloc.fetchTopIds();
    return Scaffold(
      appBar: AppBar(
        title: Text("Hacker News"),
        centerTitle: true,
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              bloc.fetchItem(snapshot.data[index]);
              return NewsListTile(
                itemId: snapshot.data[index],
              );
            },
          ),
        );
      },
    );
  }
}
