import 'package:flutter/material.dart';
import 'package:fijkplayer/fijkplayer.dart';

class VideoPage extends StatefulWidget {
  final int id;
  VideoPage(this.id);
  @override
  _VideoPage createState() => _VideoPage();
}

class _VideoPage extends State<VideoPage> {

  final FijkPlayer player = FijkPlayer();

  String playerState = "准备播放";

  @override
  void initState() {
    super.initState();

    // 检查该用户是否拥有观看次数
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        AppBar(title: Text(playerState)),
        // player && info && commend
        Container(
           // child: FijkView(player: player),
        ),
      ]),
    );
  }
}
