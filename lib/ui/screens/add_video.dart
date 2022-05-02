import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream_master/ui/screens/postVideoScreen.dart';
import 'package:stream_master/ui/screens/progress_hud.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import '../../controllers/general_controller.dart';
import '../widgets/constants.dart';
import '../widgets/tikTokVideoButtonColumn.dart';

class CreatVideo extends StatefulWidget {
  @override
  _CreatVideoState createState() => _CreatVideoState();
}

class _CreatVideoState extends State<CreatVideo> {
  AssetEntity? entity;
  Uint8List? data;
  ProgressHUD? _progressHUD;
  bool _loading = true;
  bool isFirstTime = false;

  AssetEntity? entity1;
  Uint8List? data1;

  Future<void> pick(BuildContext context) async {
    final Size size = MediaQuery.of(context).size;
    final double scale = MediaQuery.of(context).devicePixelRatio;
    final AssetEntity? _entity = await CameraPicker.pickFromCamera(
      context,
      theme: CameraPicker.themeData(color1),
      enableRecording: true,
      onlyEnableRecording: true,
      maximumRecordingDuration: const Duration(seconds: 30),
      textDelegate: EnglishCameraPickerTextDelegateWithRecording(),
    );
    setState(() {
      _loading = false;
    });
    if (_entity != null && entity != _entity) {
      entity = _entity;
      data = await _entity.thumbDataWithSize(
        (size.width * scale).toInt(),
        (size.height * scale).toInt(),
      );
      setState(() {
        if (_loading) {
          _progressHUD!.state!.dismiss();
        } else {
          _progressHUD!.state!.show();
        }

        _loading = !_loading;
      });

      if (mounted) {
        GeneralDataController.to.videoPath = await entity!.file;
        setState(() {
          _loading = true;
          Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => PostVideoScreen(
              data: data!,
            ),
          ));
        });
      }
    }
  }

  void _onImageButtonPressed() async {
    final double scale = MediaQuery.of(context).devicePixelRatio;
    List<AssetEntity>? assets = await AssetPicker.pickAssets(context,
        maxAssets: 1,
        textDelegate: EnglishTextDelegate(),
        requestType: RequestType.video,
        themeColor: color1);
    AssetEntity? _entity = assets!.first;
    setState(() {
      _loading = false;
    });
    if (entity != _entity) {
      entity = _entity;
      data = await _entity.thumbDataWithSize(
        (150 * scale).toInt(),
        (150 * scale).toInt(),
      );

      setState(() {
        if (_loading) {
          _progressHUD!.state!.dismiss();
        } else {
          _progressHUD!.state!.show();
        }

        _loading = !_loading;
      });

      if (mounted) {
        GeneralDataController.to.videoPath = await entity!.file;
        setState(() {
          _loading = true;
          Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => PostVideoScreen(
              data: data!,
            ),
          ));
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    print("init called");

    _progressHUD = ProgressHUD(
      backgroundColor: Colors.black12,
      color: Colors.white,
      containerColor: Colors.blue,
      borderRadius: 5.0,
      text: 'Loading...',
    );
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      isFirstTime = true;
      if (_progressHUD != null) {
        _loading ? _progressHUD!.state!.dismiss() : _progressHUD!.state!.show();
      }
    });
  }

  @override
  void didUpdateWidget(covariant CreatVideo oldWidget) {
    if (_progressHUD == null) {
      _progressHUD = ProgressHUD(
        backgroundColor: Colors.black12,
        color: Colors.white,
        containerColor: Colors.blue,
        borderRadius: 5.0,
        text: 'Loading...',
      );
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Widget rightButtons = Column(
      children: const [
        _CameraIconButton(
          icon: Icons.repeat,
          title: 'Flip',
        ),
        _CameraIconButton(
          icon: Icons.speed,
          title: 'speed',
        ),
        _CameraIconButton(
          icon: Icons.filter_b_and_w,
          title: 'filter',
        ),
        _CameraIconButton(
          icon: Icons.sentiment_satisfied,
          title: 'beautify',
        ),
        _CameraIconButton(
          icon: Icons.timer,
          title: 'timer',
        ),
      ],
    );
    rightButtons = Opacity(
      opacity: 0.8,
      child: Container(
        padding: EdgeInsets.only(right: 20, top: 12),
        alignment: Alignment.topRight,
        child: Container(
          child: rightButtons,
        ),
      ),
    );
    Widget selectMusic = Container(
      padding: EdgeInsets.only(left: 20, top: 20),
      alignment: Alignment.topCenter,
      child: DefaultTextStyle(
        style: TextStyle(
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.15),
              offset: Offset(0, 1),
              blurRadius: 1,
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //   fullscreenDialog: true,
            //   builder: (context) => MusicScreen(),
            // ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconToText(
                Icons.music_note,
              ),
              Text(
                'music',
              ),
              Container(width: 32, height: 12),
            ],
          ),
        ),
      ),
    );
    var closeButton = new Container(
      padding: EdgeInsets.only(left: 20, top: 20),
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          child: Icon(Icons.clear),
        ),
      ),
    );
    var cameraButton = Container(
      padding: EdgeInsets.only(bottom: 12),
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _SidePhotoButton(title: 'Props'),
            Expanded(
                child: Center(
              child: InkWell(
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        style: BorderStyle.solid,
                        color: Colors.white.withOpacity(0.4),
                        width: 6,
                      ),
                    ),
                  ),
                  onTap: () => pick(context)),
            )),
            InkWell(
              child: _SidePhotoButton(title: 'Upload'),
              onTap: () {
                _onImageButtonPressed();
                /*_onImageButtonPressed(ImageSource.gallery, _picker,
                    context: context);*/
              },
            )
          ],
        ),
      ),
    );
    var body = Stack(
      fit: StackFit.expand,
      children: <Widget>[
        _progressHUD!,
        cameraButton,
        closeButton,
        selectMusic,
        rightButtons,
      ],
    );
    if (isFirstTime) {
      _loading ? _progressHUD!.state!.dismiss() : _progressHUD!.state!.show();
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: body,
      ),
    );
  }
}

class _SidePhotoButton extends StatelessWidget {
  final String? title;

  const _SidePhotoButton({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20),
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              style: BorderStyle.solid,
              color: Colors.white,
              width: 2,
            ),
          ),
        ),
        Container(height: 2),
        Text(
          title!,
        )
      ],
    );
  }
}

class _CameraIconButton extends StatelessWidget {
  final IconData? icon;
  final String? title;

  const _CameraIconButton({
    Key? key,
    this.icon,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: DefaultTextStyle(
        style: TextStyle(shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.15),
            offset: Offset(0, 1),
            blurRadius: 1,
          ),
        ]),
        child: Column(
          children: <Widget>[
            IconToText(
              icon,
            ),
            Text(
              title!,
            ),
          ],
        ),
      ),
    );
  }
}
