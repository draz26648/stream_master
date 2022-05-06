import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  final bool all;
  final bool iscomment;
  AppLoader({this.all = false, this.iscomment = false});

  @override
  Widget build(BuildContext context) {
    if (all) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Center(child: CupertinoActivityIndicator(radius: 22)),
      );
    } else if (iscomment) {
      return const Center(
          child: CupertinoActivityIndicator(
        radius: 15,
        color: Colors.white,
      ));
    } else {
      return const Center(
          child: CupertinoActivityIndicator(
        radius: 22,
        color: Colors.white,
      ));
    }
  }
}
