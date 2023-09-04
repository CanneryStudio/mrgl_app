import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../generated/l10n.dart';

class ChewieVideoWidget extends StatefulWidget {
  final String playUrl;

  const ChewieVideoWidget(this.playUrl, {super.key});

  @override
  _ChewieVideoWidgetState createState() => _ChewieVideoWidgetState();
}

class _ChewieVideoWidgetState extends State<ChewieVideoWidget> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  Future<void> _launchUrl(String filePath) async {
    final Uri url = Uri.parse(filePath);

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
    var uri = Uri.parse(widget.playUrl);
    _videoPlayerController = VideoPlayerController.networkUrl(uri);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: () => _launchUrl(widget.playUrl),
            iconData: Icons.save,
            title: S.current.saveVideo,
          ),
        ];
      },
      // aspectRatio: 3 / 2.0,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(controller: _chewieController,);
  }
}

