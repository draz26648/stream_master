import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:stream_master/helper/image_picker_helper.dart';
import 'package:stream_master/ui/screens/main_widgets/app_loader.dart';
import 'package:stream_master/ui/screens/video_screen.dart';

class ShootingScreen extends StatefulWidget {
  const ShootingScreen({Key? key}) : super(key: key);

  @override
  State<ShootingScreen> createState() => _ShootingScreenState();
}

class _ShootingScreenState extends State<ShootingScreen> {
  bool _isLoading = true;
  late CameraController _cameraController;
  bool _isRecording = false;
  _initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back);
    _cameraController = CameraController(front, ResolutionPreset.max);
    await _cameraController.initialize();
    setState(() => _isLoading = false);
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      setState(() => _isRecording = false);
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => VideoPage(filePath: file.path,isReview: true,),
      );
      Navigator.push(context, route);
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/stack.png'),
          ),
        ),
        child: Center(
          child: AppLoader(),
        ),
      );
    } else {
      return Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: CameraPreview(_cameraController)),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      ImagePickerHelper.openGallery(onGet: (file) {
                        final route = MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (_) => VideoPage(filePath: file.path,isReview: true,),
                        );
                        Navigator.push(context, route);
                      });
                    },
                    icon: const ImageIcon(
                      AssetImage('assets/images/gallary.png'),
                      size: 32,
                    ),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: Icon(_isRecording ? Icons.stop : Icons.circle),
                    onPressed: () => _recordVideo(),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const ImageIcon(
                      AssetImage('assets/images/switch.png'),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
