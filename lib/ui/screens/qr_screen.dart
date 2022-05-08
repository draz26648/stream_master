import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRScreen extends StatelessWidget {
  final String image;
  const QRScreen({Key? key,required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR code'),
        backgroundColor: Color(0xffFF1CB8),
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffFF1CB8),
              Color(0xffFF4E83),
              Color(0xffFFA920),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Container(
          width: 252,
          height: 252,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              QrImage(
                data: 'https://www.google.com',
                version: QrVersions.auto,
                size: 200.0,
              ),
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(image),
                  radius: ScreenUtil().setWidth(25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
