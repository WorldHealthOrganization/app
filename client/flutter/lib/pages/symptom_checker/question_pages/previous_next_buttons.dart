import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreviousNextButtons extends StatelessWidget {
  final bool showPrevious;
  final bool enableNext;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const PreviousNextButtons({
    Key key,
    @required this.showPrevious,
    @required this.enableNext,
    @required this.onPrevious,
    @required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        showPrevious
            ? FlatButton(
                color: Colors.grey,
                child: Text("Previous"),
                onPressed: onPrevious)
            : Container(),
        FlatButton(
            color: Colors.grey,
            child: Text("Next"),
            onPressed: enableNext ? onNext : null),
      ],
    );
  }
}
