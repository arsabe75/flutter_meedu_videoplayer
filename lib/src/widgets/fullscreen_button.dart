import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';

import 'player_button.dart';

class FullscreenButton extends StatelessWidget {
  final double size;
  const FullscreenButton({Key? key, this.size = 30}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = MeeduPlayerController.of(context);
    return RxBuilder(
      //observables: [_.fullscreen],
      (__) {
        String iconPath = 'assets/icons/minimize.png';
        Widget? customIcon = c.customIcons.minimize;

        if (!c.fullscreen.value) {
          iconPath = 'assets/icons/fullscreen.png';
          customIcon = c.customIcons.fullscreen;
        }
        return PlayerButton(
          size: size,
          circle: false,
          backgrounColor: Colors.transparent,
          iconColor: Colors.white,
          iconPath: iconPath,
          customIcon: customIcon,
          onPressed: () {
            if (c.fullscreen.value) {
              // exit to fullscreen
              if (c.windows) {
                c.screenManager.setWindowsFullScreen(false, c);
              } else {
                Navigator.pop(context);
              }
            } else {
              if (c.windows) {
                c.screenManager.setWindowsFullScreen(true, c);
              } else {
                c.goToFullscreen(context);
              }
            }
          },
        );
      },
    );
  }
}
