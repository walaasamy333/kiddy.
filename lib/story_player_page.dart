import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'coloring_page.dart';

class StoryPlayerPage extends StatefulWidget {
  final Map<String, String> storyData;

  const StoryPlayerPage({Key? key, required this.storyData}) : super(key: key);

  @override
  State<StoryPlayerPage> createState() => _StoryPlayerPageState();
}

class _StoryPlayerPageState extends State<StoryPlayerPage> {
  late VideoPlayerController _introVideoController;
  late VideoPlayerController _mainVideoController;
  ChewieController? _chewieController;
  bool _isIntroVideoPlaying = true;
  bool _showEndMessage = false;

  @override
  void initState() {
    super.initState();
    _playIntroVideo();
  }

  Future<void> _playIntroVideo() async {
    _introVideoController = VideoPlayerController.asset('assets/vidio/bb.mp4');
    await _introVideoController.initialize();
    setState(() {});
    _introVideoController.play();
    _introVideoController.addListener(() {
      if (_introVideoController.value.position >= _introVideoController.value.duration) {
        _isIntroVideoPlaying = false;
        _playMainVideo();
      }
    });
  }

  Future<void> _playMainVideo() async {
    _mainVideoController = VideoPlayerController.asset(widget.storyData['video_path']!);
    await _mainVideoController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _mainVideoController,
      autoPlay: true,
      looping: false,
      aspectRatio: _mainVideoController.value.aspectRatio,
      showControls: true,
    );

    _mainVideoController.addListener(() {
      if (_mainVideoController.value.position >= _mainVideoController.value.duration) {
        if (!_showEndMessage) {
          setState(() {
            _showEndMessage = true;
          });
          _showEndButtons();
        }
      }
    });

    setState(() {});
  }

  void _showEndButtons() {
    Future.delayed(const Duration(seconds: 2), () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Is the little hero ready to color?'),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {

                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Back to Stories'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ColoringPage(
                          imagePath: widget.storyData['coloring_image_path']!,
                        ),
                      ),
                    );
                  },
                  child: const Text('Go to Color'),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  @override
  void dispose() {
    _introVideoController.dispose();
    _mainVideoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.storyData['title']!),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: _isIntroVideoPlaying
            ? (_introVideoController.value.isInitialized
            ? SizedBox.expand(
          child: VideoPlayer(_introVideoController),
        )
            : const CircularProgressIndicator())
            : _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
            ? Chewie(controller: _chewieController!)
            : const CircularProgressIndicator(),
      ),
    );
  }
}