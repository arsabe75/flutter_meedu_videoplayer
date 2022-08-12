import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';
import 'package:flutter_meedu_videoplayer/src/helpers/responsive.dart';
import 'package:flutter_meedu_videoplayer/src/helpers/utils.dart';
import 'package:flutter_meedu_videoplayer/src/widgets/fullscreen_button.dart';
import 'package:flutter_meedu_videoplayer/src/widgets/mute_sound_button.dart';
import 'package:flutter_meedu_videoplayer/src/widgets/play_back_speed.dart';
import 'package:flutter_meedu_videoplayer/src/widgets/player_slider.dart';
import 'package:flutter_meedu_videoplayer/src/widgets/video_fit_button.dart';

class PrimaryBottomControls extends StatelessWidget {
  final Responsive responsive;
  const PrimaryBottomControls({Key? key, required this.responsive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = MeeduPlayerController.of(context);
    final fontSize = responsive.ip(2.5);
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: fontSize > 16 ? 16 : fontSize,
    );
    return Positioned(
      left: 5,
      right: 0,
      bottom: 20,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // START VIDEO POSITION
          RxBuilder(
              //observables: [_.duration, _.position],
              (__) {
            return Text(
              c.duration.value.inMinutes >= 60
                  ? printDurationWithHours(c.position.value)
                  : printDuration(c.position.value),
              style: textStyle,
            );
          }),
          // END VIDEO POSITION
          const SizedBox(width: 10),
          const Expanded(
            child: PlayerSlider(),
          ),
          const SizedBox(width: 10),
          // START VIDEO DURATION
          RxBuilder(
            //observables: [_.duration],
            (__) => Text(
              c.duration.value.inMinutes >= 60
                  ? printDurationWithHours(c.duration.value)
                  : printDuration(c.duration.value),
              style: textStyle,
            ),
          ),
          // END VIDEO DURATION
          const SizedBox(width: 15),
          if (c.bottomRight != null) ...[
            c.bottomRight!,
            const SizedBox(width: 5)
          ],

          //if (_.enabledButtons.pip) PipButton(responsive: responsive),

          if (c.enabledButtons.videoFit) VideoFitButton(responsive: responsive),
          if (c.enabledButtons.playBackSpeed)
            PlayBackSpeedButton(responsive: responsive, textStyle: textStyle),
          if (c.enabledButtons.muteAndSound)
            MuteSoundButton(responsive: responsive),

          if (c.enabledButtons.fullscreen)
            FullscreenButton(
              size: responsive.ip(c.fullscreen.value ? 5 : 7),
            )
        ],
      ),
    );
  }
}
