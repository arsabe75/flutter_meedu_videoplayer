import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';

import 'package:flutter_meedu_videoplayer/src/helpers/responsive.dart';
import 'player_button.dart';

class VideoFitButton extends StatelessWidget {
  final Responsive responsive;
  const VideoFitButton({Key? key, required this.responsive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = MeeduPlayerController.of(context);
    return RxBuilder(
        //observables: [_.fullscreen],
        (__) {
      String iconPath = 'assets/icons/fit.png';
      Widget? customIcon = c.customIcons.videoFit;

      return PlayerButton(
        size: responsive.ip(c.fullscreen.value ? 5 : 7),
        circle: false,
        backgrounColor: Colors.transparent,
        iconColor: Colors.white,
        iconPath: iconPath,
        customIcon: customIcon,
        onPressed: () {
          debugPrint("s");
          c.toggleVideoFit();
        },
      );
    });
  }
}
