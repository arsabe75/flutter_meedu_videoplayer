import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';
import 'package:flutter_meedu_videoplayer/src/helpers/responsive.dart';
import 'package:flutter_meedu_videoplayer/src/widgets/styles/primary/primary_player_controls.dart';
import 'package:flutter_meedu_videoplayer/src/widgets/styles/secondary/secondary_player_controls.dart';

import 'closed_caption_view.dart';

class MeeduVideoPlayer extends StatefulWidget {
  final MeeduPlayerController controller;

  final Widget Function(
    BuildContext context,
    MeeduPlayerController controller,
    Responsive responsive,
  )? header;

  final Widget Function(
    BuildContext context,
    MeeduPlayerController controller,
    Responsive responsive,
  )? bottomRight;

  final CustomIcons Function(
    Responsive responsive,
  )? customIcons;

  const MeeduVideoPlayer({
    Key? key,
    required this.controller,
    this.header,
    this.bottomRight,
    this.customIcons,
  }) : super(key: key);

  @override
  MeeduVideoPlayerState createState() => MeeduVideoPlayerState();
}

class MeeduVideoPlayerState extends State<MeeduVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return MeeduPlayerProvider(
      controller: widget.controller,
      child: Container(
          color: Colors.black,
          width: 0.0,
          height: 0.0,
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              MeeduPlayerController c = widget.controller;
              final responsive = Responsive(
                constraints.maxWidth,
                constraints.maxHeight,
              );

              if (widget.customIcons != null) {
                c.customIcons = widget.customIcons!(responsive);
              }

              if (widget.header != null) {
                c.header = widget.header!(context, c, responsive);
              }

              if (widget.bottomRight != null) {
                c.bottomRight = widget.bottomRight!(context, c, responsive);
              }

              return Stack(
                alignment: Alignment.center,
                children: [
                  if (c.windows)
                    RxBuilder(
                        //observables: [_.videoFit],
                        (__) {
                      //print("NATIVE HAS BEEN REBUILT ${_.videoPlayerControllerWindows}");
                      c.dataStatus.status.value;
                      if (c.videoPlayerControllerWindows == null) {
                        return const Text("Loading");
                      }

                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          /*
                          Platform.isWindows
                              ? NativeVideo(
                                  player: _.videoPlayerControllerWindows!,
                                  showControls: false,
                                )
                              : Video(
                                  player: _.videoPlayerControllerWindows!,
                                  showControls: false,
                                ),
                           */
                          Video(
                            player: c.videoPlayerControllerWindows!,
                            showControls: false,
                          ),
                        ],
                      );
                    })
                  else
                    RxBuilder(
                        //observables: [_.videoFit],
                        (__) {
                      c.dataStatus.status.value;
                      debugPrint("Fit is ${widget.controller.videoFit.value}");
                      return SizedBox.expand(
                        child: FittedBox(
                          fit: widget.controller.videoFit.value,
                          child: SizedBox(
                            width: c.videoPlayerController != null
                                ? c.videoPlayerController!.value.size.width
                                : 640,
                            height: c.videoPlayerController != null
                                ? c.videoPlayerController!.value.size.height
                                : 480,
                            child: VideoPlayer(c.videoPlayerController!),
                          ),
                        ),
                      );
                    }),
                  ClosedCaptionView(responsive: responsive),
                  if (c.controlsEnabled &&
                      c.controlsStyle == ControlsStyle.primary)
                    PrimaryVideoPlayerControls(
                      responsive: responsive,
                    ),
                  if (c.controlsEnabled &&
                      c.controlsStyle == ControlsStyle.secondary)
                    SecondaryVideoPlayerControls(
                      responsive: responsive,
                    ),
                ],
              );
            },
          )),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class MeeduPlayerProvider extends InheritedWidget {
  final MeeduPlayerController controller;

  const MeeduPlayerProvider({
    Key? key,
    required Widget child,
    required this.controller,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
