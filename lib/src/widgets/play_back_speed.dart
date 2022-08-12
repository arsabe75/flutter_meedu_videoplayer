import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';

import 'package:flutter_meedu_videoplayer/src/helpers/responsive.dart';

class PlayBackSpeedButton extends StatelessWidget {
  final Responsive responsive;
  final TextStyle textStyle;
  const PlayBackSpeedButton(
      {Key? key, required this.responsive, required this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = MeeduPlayerController.of(context);
    return RxBuilder(
        //observables: [_.fullscreen],
        (__) {
      return TextButton(
        style: TextButton.styleFrom(
          padding:
              EdgeInsets.all(responsive.ip(c.fullscreen.value ? 5 : 7) * 0.25),
        ),
        onPressed: () {
          debugPrint("s");
          c.togglePlaybackSpeed();
        },
        child: Text(
          c.playbackSpeed.toString(),
          style: textStyle,
        ),
      );
    });
  }
}
