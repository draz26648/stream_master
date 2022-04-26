import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stream_master/ui/widgets/shoot_bottom_bar_kind_widget.dart';
import 'package:stream_master/ui/widgets/shoot_bottom_bar_widget.dart';

import 'package:video_player/video_player.dart';

import '../screens/postVideoScreen.dart';

//Shooting Page Bottom Layout
class ShootBottomWidget extends StatefulWidget {
   VoidCallback? shootingPress;
   ShootBottomWidget({Key? key, this.shootingPress}) : super(key: key);

  @override
  _ShootBottomWidgetState createState() {
    return _ShootBottomWidgetState();
  }
}

class _ShootBottomWidgetState extends State<ShootBottomWidget> {
  Uint8List? data;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Column(
        children: [
          ShootBottomBarKindWidget(
            width: 200,
            height: 50,
            list: ['Live', 'Clip'],
            initialItem: 1,
            onSelected: (index) {},
          ),
          _getMiddleLayout(),
        ],
      ),
    );
  }

  _getMiddleLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _getLeftLayout(),
        SizedBox(
          width: 40,
        ),
        FlashButton(
          size: 70,
          onPressed: (){
            
          },
          
        ),
        SizedBox(
          width: 40,
        ),
        _getRightLayout(),
      ],
    );
  }

  _getLeftLayout() {
    return IconButton(
      onPressed: () {
        Fluttertoast.showToast(msg: 'Features to be developed');
      },
      icon: const ImageIcon(
        AssetImage('assets/images/switch.png'),
        color: Colors.white,
      ),
    );
  }

  _getRightLayout() {
    return IconButton(
      onPressed: () async {
        var videoFile =
            await ImagePicker().pickVideo(source: ImageSource.gallery);
        Navigator.of(context).push(MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => PostVideoScreen(
            data: data!,
          ),
        ));
      },
      icon: ImageIcon(
        AssetImage('assets/images/gallary.png'),
        size: 32,
      ),
    );
  }
}

class FlashButton extends StatelessWidget {
  double? size = 66;
  double borderWidth = 4;
  VoidCallback? onPressed;

  FlashButton({this.size,this.onPressed});

  @override
  Widget build(BuildContext context) {
    double innerSize = size! - borderWidth * 2 - 4;
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size! / 2),
          border: Border.fromBorderSide(
              BorderSide(color: Colors.white, width: borderWidth)),
        ),
        alignment: Alignment.center,
        child: Container(
          width: innerSize,
          height: innerSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(innerSize / 2),
            color: Colors.white,
          ),
          child: Image.asset(
            'assets/images/flash.png',
            width: 5,
            height: 5,
          ),
        ),
      ),
    );
  }
}
