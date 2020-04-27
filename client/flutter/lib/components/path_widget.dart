import 'package:flutter/cupertino.dart';

/// Draws a path with custom paint and a nudge property.
class PathWidget extends LeafRenderObjectWidget {
  /// The path that will be drawn inside this widget.
  final Path path;

  /// Paint to use when drawing the path.
  final Paint paint;

  /// Use nudge to move the path to whole screen coordinates to improve
  /// clarity/crispness (usually it's sufficient to bump x/y by 0.5 pixels).
  final Offset nudge;

  const PathWidget({
    @required this.path,
    @required this.paint,
    this.nudge = Offset.zero,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _PathRenderObject()
      ..path = path
      ..pathPaint = paint
      ..nudge = nudge;
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _PathRenderObject renderObject) {
    renderObject
      ..path
      ..pathPaint = paint
      ..nudge = nudge;
  }
}

class _PathRenderObject extends RenderBox {
  Path _path;
  Rect _bounds;
  Paint _paint;
  Offset _nudge;

  Path get path => _path;
  set path(Path value) {
    if (_path == value) {
      return;
    }
    _path = value;
    _bounds = value.getBounds();
    markNeedsPaint();
  }

  Offset get nudge => _nudge;
  set nudge(Offset value) {
    if (_nudge == value) {
      return;
    }
    _nudge = value;
    markNeedsPaint();
  }

  Paint get pathPaint => _paint;
  set pathPaint(Paint value) {
    if (_paint == value) {
      return;
    }
    _paint = value;
    markNeedsPaint();
  }

  @override
  void performLayout() {
    size = constraints.constrain(_bounds.size);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    var canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx.roundToDouble() + nudge.dx - _bounds.left,
        offset.dy.roundToDouble() + nudge.dy - _bounds.top);
    canvas.drawPath(path, pathPaint);
    canvas.restore();
  }
}
