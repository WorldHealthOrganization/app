import 'package:who_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';


class ShareBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
                bottom: 0,
                child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                color: Colors.white.withOpacity(.85),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.share),
                    iconSize: 28,
                    onPressed: ()=>Share.share(S.of(context).commonWhoAppShareIconButtonDescription),
                  ),
                ),
              ));
  }
}
