import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerWidget extends StatefulWidget {
  final String? id;
  const YoutubePlayerWidget({Key? key, required this.id}) : super(key: key);

  @override
  State<YoutubePlayerWidget> createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = YoutubePlayerController(
        initialVideoId: widget.id!.toString(),
        flags: const YoutubePlayerFlags(
            controlsVisibleAtStart: false,
            hideControls: true,
            autoPlay: true,
            mute: false,
            disableDragSeek: true,
            hideThumbnail: true));
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
        controlsTimeOut: Duration(seconds: 1),
        progressIndicatorColor: Colors.amber,
        progressColors: ProgressBarColors(
            backgroundColor: Colors.black,
            playedColor: Colors.white,
            bufferedColor: Colors.grey[700],
            handleColor: Colors.amber),
        showVideoProgressIndicator: false,
      ),
      builder: (context, player) => Container(
        child: player,
      ),
    );
  }
}
