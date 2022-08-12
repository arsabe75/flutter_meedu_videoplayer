import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';
import 'package:flutter_meedu_videoplayer/src/helpers/responsive.dart';
import 'package:flutter_meedu_videoplayer/src/widgets/play_pause_button.dart';
import 'package:flutter_meedu_videoplayer/src/widgets/player_button.dart';
import 'package:flutter_meedu_videoplayer/src/widgets/styles/controls_container.dart';
import 'package:flutter_meedu_videoplayer/src/widgets/styles/primary/bottom_controls.dart';

class PrimaryVideoPlayerControls extends StatelessWidget {
  final Responsive responsive;
  const PrimaryVideoPlayerControls({Key? key, required this.responsive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = MeeduPlayerController.of(context);

    return ControlsContainer(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // RENDER A CUSTOM HEADER
          if (c.header != null)
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: c.header!,
              ),
            ),
          SizedBox(
            height: context.mediaQuerySize.height,
            width: context.mediaQuerySize.width,
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (c.enabledButtons.rewindAndfastForward) ...[
                PlayerButton(
                  onPressed: c.rewind,
                  size: responsive.ip(c.fullscreen.value ? 8 : 12),
                  iconColor: Colors.white,
                  backgrounColor: Colors.transparent,
                  iconPath: 'assets/icons/rewind.png',
                  customIcon: c.customIcons.rewind,
                ),
                const SizedBox(width: 10),
              ],
              if (c.enabledButtons.playPauseAndRepeat)
                RxBuilder(
                    //observables: [_.showSwipeDuration],
                    //observables: [_.swipeDuration],
                    (__) {
                  c.dataStatus.status.value;
                  if (!c.showSwipeDuration.value &&
                      !c.dataStatus.error &&
                      !c.dataStatus.loading &&
                      !c.isBuffering.value) {
                    return PlayPauseButton(
                      size: responsive.ip(c.fullscreen.value ? 8 : 13),
                    );
                  } else {
                    return Container();
                  }
                }),
              if (c.enabledButtons.rewindAndfastForward) ...[
                const SizedBox(width: 10),
                PlayerButton(
                  onPressed: c.fastForward,
                  iconColor: Colors.white,
                  backgrounColor: Colors.transparent,
                  size: responsive.ip(c.fullscreen.value ? 8 : 12),
                  iconPath: 'assets/icons/fast-forward.png',
                  customIcon: c.customIcons.fastForward,
                ),
              ]
            ],
          ),

          PrimaryBottomControls(
            responsive: responsive,
          ),
        ],
      ),
    );
  }
}
