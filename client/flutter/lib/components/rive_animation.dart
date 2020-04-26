import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Play a Rive animation when the percentage of the surface area of the widget
/// is at least [visibilityThreshold] on screen.
class RiveAnimation extends StatefulWidget {
  final String filename;
  final Alignment alignment;
  final BoxFit fit;
  final String animation;
  final double visibilityThreshold;

  const RiveAnimation(
    this.filename, {
    Key key,
    this.alignment,
    this.fit,
    this.animation,
    this.visibilityThreshold = 0.5,
  }) : super(key: key);

  @override
  _RiveAnimationState createState() => _RiveAnimationState();
}

class _RiveAnimationState extends State<RiveAnimation> {
  final GlobalKey _key = GlobalKey();
  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;
  set isPlaying(bool value) {
    if (!mounted) {
      return;
    }
    if (_isPlaying != value) {
      setState(() {
        _isPlaying = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) => VisibilityDetector(
        key: _key,
        onVisibilityChanged: (info) {
          isPlaying = info.visibleFraction > widget.visibilityThreshold;
        },
        child: FlareActor(
          widget.filename,
          alignment: widget.alignment,
          fit: widget.fit,
          animation: widget.animation,
          isPaused: !_isPlaying,
        ),
      );
}
