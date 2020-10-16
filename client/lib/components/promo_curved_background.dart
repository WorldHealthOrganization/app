import 'package:flutter/cupertino.dart';

class PromoCurvedBackground extends StatelessWidget {
  final Color color;

  const PromoCurvedBackground({@required this.color, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _BackgroundClipper(),
      child: Container(color: color),
    );
  }
}

class _BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height);
    path.arcToPoint(Offset(size.width, size.height - 33.0),
        radius: Radius.elliptical(size.width, 200.0));
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> path) {
    return false;
  }
}
