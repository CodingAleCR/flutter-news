import 'package:flutter/material.dart';
import '../blocs/app_provider.dart';
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = AppProvider.storiesBlocOf(context);
    //Don't do this, this is baaad!!! If the call ends up rebuilding the complete widget we would
    //end up with an infinite loop. The ideal place to do this is with the navigation.
    // bloc.fetchTopIds();
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: Center(
            child: Text(
              "Y",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          color: Colors.orange[800],
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Hacker News",
              style: TextStyle(
                color: Colors.orange[800],
              ),
            ),
            Text(
              "Top Stories",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.orange[800],
              ),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: buildList(bloc),
        ),
      ),
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
