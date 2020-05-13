import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:who_app/components/page_button.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class NextButton extends StatelessWidget {
  final bool enableNext;
  final VoidCallback onNext;

  const NextButton({
    Key key,
    @required this.enableNext,
    @required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageButton(
      Constants.whoBackgroundBlueColor,
      // TODO: Localize
      "Next",
      enableNext ? onNext : null,
      borderRadius: 50,
      crossAxisAlignment: CrossAxisAlignment.center,
      titleStyle: ThemedText.styleForVariant(TypographyVariant.h4)
          .merge(TextStyle(color: CupertinoColors.white)),
    );
  }
}
