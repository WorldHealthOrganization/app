import 'package:flutter/material.dart';

class EmojiHeader extends StatelessWidget {
  EmojiHeader(this.emoji);

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        this.emoji,
        textScaleFactor: 6,
      ),
    );
  }
}
