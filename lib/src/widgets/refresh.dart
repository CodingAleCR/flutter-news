import 'package:flutter/material.dart';
import '../blocs/app_provider.dart';

class Refresh extends StatelessWidget {
  final Widget child;
  Refresh({this.child});

  @override
  Widget build(BuildContext context) {
    final bloc = AppProvider.storiesBlocOf(context);
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc.clearCache();
        await bloc.fetchTopIds();
      },
    );
  }
}
