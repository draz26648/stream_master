import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool padding;
  final Color? color;
  final Color? txtColor;
  final bool? loading;
  final double? width;

  const CustomBtn({Key? key, required this.text, required this.onTap, this.padding = false, this.color, this.txtColor,this.loading = false,this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (loading ?? false) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: CupertinoActivityIndicator(radius: 20),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(padding ? 24 : 0),
        child: MaterialButton(
          onPressed: onTap,
          height: 48,
          color: color ?? Theme.of(context).primaryColor,
          elevation: 1,
          minWidth:width?? MediaQuery.of(context).size.width,
        textColor: txtColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Text(text, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
      ),
    );}
  }
}
