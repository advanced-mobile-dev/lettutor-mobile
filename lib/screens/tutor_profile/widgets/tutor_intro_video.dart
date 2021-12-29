import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TutorIntroVideo extends StatefulWidget {
  final String videoUrl;
  final String name;

  TutorIntroVideo(this.name, this.videoUrl);
  @override
  _TutorIntroVideoState createState() => _TutorIntroVideoState();
}

class _TutorIntroVideoState extends State<TutorIntroVideo> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      widget.videoUrl,
    );
    print(widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Stack(
                  children: [
                    Container(
                      height: 300,
                      child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller)),
                    ),
                    Positioned(
                        bottom: 0,
                        width: MediaQuery.of(context).size.width,
                        child: VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                          padding: EdgeInsets.only(bottom: 5),
                          colors: VideoProgressColors(
                              backgroundColor: Colors.blueGrey,
                              bufferedColor: Colors.blueGrey,
                              playedColor: Colors.orange),
                        )),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (_controller.value.isPlaying) {
                                  _controller.pause();
                                } else {
                                  _controller.play();
                                }
                              });
                            },
                            icon: Icon(
                              _controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            )))
                  ],
                ),
                SizedBox(
                  height: 40,
                )
              ]),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
