import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';

import 'player_button.dart';

class PlayPauseButton extends StatelessWidget {
  final double size;
  const PlayPauseButton({Key? key, this.size = 40}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = MeeduPlayerController.of(context);
    return RxBuilder(
      //observables: [
      //  _.playerStatus.status,
      //  _.buffered,
      //  _.isBuffering,
      //  _.position
      //],
      (__) {
        if (c.isBuffering.value) {
          return CupertinoButton(onPressed: c.pause, child: c.loadingWidget!);
        }

        String iconPath = 'assets/icons/repeat.png';
        Widget? customIcon = c.customIcons.repeat;
        if (c.playerStatus.playing) {
          iconPath = 'assets/icons/pause.png';
          customIcon = c.customIcons.pause;
        } else if (c.playerStatus.paused) {
          iconPath = 'assets/icons/play.png';
          customIcon = c.customIcons.play;
        }
        return PlayerButton(
          backgrounColor: Colors.transparent,
          iconColor: Colors.white,
          onPressed: () {
            if (c.playerStatus.playing) {
              c.pause();
            } else if (c.playerStatus.paused) {
              c.play();
            } else {
              c.play(repeat: true);
            }
          },
          size: size,
          iconPath: iconPath,
          customIcon: customIcon,
        );
      },
    );
  }
}
