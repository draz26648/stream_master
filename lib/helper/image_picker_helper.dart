import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImagePickerHelper {
  static showOption(
      {required BuildContext context, required ValueChanged<File> onGet}) {
    showDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Center(child: Text('Select Image Source')),
          actions: [
            CupertinoDialogAction(
                child: Text('Gallery'),
                onPressed: () => openGallery(onGet: onGet)),
            CupertinoDialogAction(
                child: Text('Camera'),
                onPressed: () => openCamera(onGet: onGet)),
          ],
        );
      },
    );
  }

  static openGallery({required ValueChanged<File> onGet}) async {
    var _image = await ImagePicker().pickVideo(source: ImageSource.gallery);
    onGet(File(_image!.path));
  }

  static openCamera({required ValueChanged<File> onGet}) async {
    var _image = await ImagePicker().pickVideo(source: ImageSource.camera);
    onGet(File(_image!.path));
  }
}
