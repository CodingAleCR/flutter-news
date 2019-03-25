import 'package:flutter/material.dart';
import '../item_detail_title.dart';
import '../item_detail.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      iconTheme: IconThemeData(
        color: Colors.orange[800], //change your color here
      ),
      title: ItemDetailTitle(),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
    ),
      body: ItemDetail(),
    );
  }
}
