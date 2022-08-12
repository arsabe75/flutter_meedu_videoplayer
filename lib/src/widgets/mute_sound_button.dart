import 'package:flutter/material.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';

import 'package:flutter_meedu/ui.dart';

import 'package:flutter_meedu_videoplayer/src/helpers/responsive.dart';

import 'player_button.dart';

class MuteSoundButton extends StatelessWidget {
  final Responsive responsive;
  const MuteSoundButton({Key? key, required this.responsive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = MeeduPlayerController.of(context);
    return RxBuilder(
        //observables: [_.mute, _.fullscreen],
        (__) {
      String iconPath = 'assets/icons/mute.png';
      Widget? customIcon = c.customIcons.mute;

      if (!c.mute.value) {
        iconPath = 'assets/icons/sound.png';
        customIcon = c.customIcons.sound;
      }

      return PlayerButton(
        size: responsive.ip(c.fullscreen.value ? 5 : 7),
        circle: false,
        backgrounColor: Colors.transparent,
        iconColor: Colors.white,
        iconPath: iconPath,
        customIcon: customIcon,
        onPressed: () {
          c.setMute(!c.mute.value);
        },
      );
    });
  }
}
