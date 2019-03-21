import 'package:flutter/material.dart';

class LoadingTile extends StatelessWidget {
  Widget build(context) {
    return Card(
      margin: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
      child: ListTile(
        title: buildTextContainer(150.0),
        subtitle: buildTextContainer(50.0),
      ),
    );
  }

  Widget buildTextContainer(double width) {
    return Container(
      color: Colors.grey[400],
      height: 24.0,
      width: width,
      margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
    );
  }
}
