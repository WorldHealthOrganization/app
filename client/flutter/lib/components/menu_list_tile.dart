import 'package:flutter/material.dart';
import 'package:who_app/components/themed_text.dart';

class MenuListTile extends StatelessWidget {
  const MenuListTile({
    Key key,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: ThemedText(title, variant: TypographyVariant.button),
        trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFFC9CDD6)),
        onTap: onTap,
      ),
    );
  }
}
