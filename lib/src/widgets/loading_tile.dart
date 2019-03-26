import 'package:flutter/material.dart';

class LoadingTile extends StatelessWidget {
  Widget build(context) {
    return ListTile(
      title: buildTextContainer(150.0),
      subtitle: buildTextContainer(50.0),
    );
  }

  Widget buildTextContainer(double width) {
    return Container(
      color: Colors.grey[300],
      height: 24.0,
      width: width,
      margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
    );
  }
}
