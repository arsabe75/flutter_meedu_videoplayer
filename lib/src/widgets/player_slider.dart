import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';
import 'package:flutter_meedu_videoplayer/src/helpers/utils.dart';

class PlayerSlider extends StatelessWidget {
  const PlayerSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = MeeduPlayerController.of(context);
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        LayoutBuilder(builder: (ctx, constraints) {
          return RxBuilder(
            //observables: [_.buffered, _.duration],
            (__) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: Colors.white30,
                width: constraints.maxWidth * c.bufferedPercent.value,
                height: 3,
              );
            },
          );
        }),
        RxBuilder(
          //observables: [_.sliderPosition, _.duration],
          (__) {
            final int value = c.sliderPosition.value.inSeconds;
            final double max = c.duration.value.inSeconds.toDouble();
            if (value > max || max <= 0) {
              return Container();
            }
            return Container(
              constraints: const BoxConstraints(
                maxHeight: 30,
              ),
              padding: const EdgeInsets.only(bottom: 8),
              alignment: Alignment.center,
              child: SliderTheme(
                data: SliderThemeData(
                  trackShape: MSliderTrackShape(),
                  thumbColor: c.colorTheme,
                  activeTrackColor: c.colorTheme,
                  trackHeight: 10,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 4.0),
                ),
                child: Slider(
                  min: 0,
                  divisions: c.duration.value.inSeconds,
                  value: value.toDouble(),
                  onChangeStart: (v) {
                    c.onChangedSliderStart();
                  },
                  onChangeEnd: (v) {
                    c.onChangedSliderEnd();
                    c.seekTo(
                      Duration(seconds: v.floor()),
                    );
                  },
                  label: printDuration(c.sliderPosition.value),
                  max: max,
                  onChanged: c.onChangedSlider,
                ),
              ),
            );
          },
        )
      ],
    );
  }
}

class MSliderTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    SliderThemeData? sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    const double trackHeight = 1;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2 + 4;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
