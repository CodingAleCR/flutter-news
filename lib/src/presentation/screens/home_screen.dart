import 'package:flutter/material.dart';
import '../list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          child: StoryList(),
        ),
      ),
    );
  }
}
