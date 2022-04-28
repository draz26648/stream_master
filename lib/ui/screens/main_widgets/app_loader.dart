import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  final bool all;

  AppLoader({this.all = false});

  @override
  Widget build(BuildContext context) {
    if (all) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Center(child: CupertinoActivityIndicator(radius: 22)),
      );
    } else {
      return Center(child: CupertinoActivityIndicator(radius: 22));
    }
  }
}
