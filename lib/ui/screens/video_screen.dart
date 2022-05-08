import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:stream_master/ui/screens/main_widgets/custom_btn.dart';
import 'package:stream_master/ui/screens/postVideoScreen.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final String filePath;
  final bool isReview;
  const VideoPage({Key? key, required this.filePath, required this.isReview})
      : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isReview
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.black26.withOpacity(0.01),
              actions: [
                IconButton(
                  icon:
                      const ImageIcon(AssetImage('assets/images/tag-user.png')),
                  onPressed: () {
                    
                  },
                ),
                IconButton(
                  icon: const ImageIcon(AssetImage('assets/images/link-2.png')),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const ImageIcon(AssetImage('assets/images/music-circle.png')),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const ImageIcon(AssetImage('assets/images/scissor.png')),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const ImageIcon(AssetImage('assets/images/edit.png')),
                  onPressed: () {},
                ),
              ],
            )
          : null,
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _initVideoPlayer(),
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Stack(
              children: [
                VideoPlayer(_videoPlayerController),
                Positioned(
                  bottom: 40,
                  left: 15,
                  right: 15,
                  child: CustomBtn(onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PostVideoScreen(
                          videoPath: widget.filePath,
                        ),
                      ),
                    );
                  },
                  text: 'Next',
                  color: Color(0xff292D32),
                  )
                  ),

              ],
            );
          }
        },
      ),
    );
  }
}
