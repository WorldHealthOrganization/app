import 'package:flutter/material.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class MenuListTile extends StatelessWidget {
  const MenuListTile({
    Key key,
    @required this.title,
    @required this.onTap,
    this.subtitle,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    this.hasArrow = true,
    this.titleStyle,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final EdgeInsets contentPadding;
  final VoidCallback onTap;
  final bool hasArrow;
  final TextStyle titleStyle;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: ListTile(
        contentPadding: contentPadding,
        title: ThemedText(
          title,
          variant: TypographyVariant.button,
          style: titleStyle,
        ),
        subtitle: subtitle != null
            ? ThemedText(
                subtitle,
                variant: TypographyVariant.body,
              )
            : null,
        trailing: hasArrow
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.arrow_forward_ios, color: Constants.neutral3Color),
                ],
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
