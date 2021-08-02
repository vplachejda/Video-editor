import 'package:flutter/material.dart';
import 'package:video_editor/domain/bloc/controller.dart';

class TrimTimeline extends StatefulWidget {
  ///Slider that trim video length.
  TrimTimeline(
      {Key? key,
      required this.controller,
      this.secondGap,
      this.margin = EdgeInsets.zero})
      : super(key: key);

  ///Essential argument for the functioning of the Widget
  final VideoEditorController controller;

  ///The time in seconds between every point of the timeline (5 sec by default)
  final double? secondGap;

  /// Empty space to surround the widget
  final EdgeInsets margin;

  @override
  _TrimTimelineState createState() => _TrimTimelineState();
}

class _TrimTimelineState extends State<TrimTimeline> {
  int _timeGap = 0;

  @override
  void initState() {
    final double _secondGap = widget.secondGap ?? 5;
    final Duration _duration =
        widget.controller.maxDuration < widget.controller.videoDuration
            ? widget.controller.maxDuration
            : widget.controller.videoDuration;
    _timeGap = (_duration.inSeconds / (_secondGap + 1)).ceil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: widget.margin,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0;
                  i <=
                      (widget.controller.videoDuration.inSeconds / _timeGap)
                          .ceil();
                  i++)
                Text(
                  (i * _timeGap <= widget.controller.videoDuration.inSeconds
                          ? i * _timeGap
                          : '')
                      .toString(),
                ),
            ]));
  }
}
