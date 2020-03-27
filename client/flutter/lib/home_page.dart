import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/page_scaffold.dart';
import 'package:WHOFlutter/pages/protect_yourself.dart';
import 'package:WHOFlutter/pages/who_myth_busters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        body: StaggeredGridView.count(
      crossAxisCount: 2,
      staggeredTiles: [
        StaggeredTile.count(1, 2),
        StaggeredTile.count(1, 1),
        StaggeredTile.count(1, 1),
        StaggeredTile.count(2, 1),
      ],
      children: [
        PageButton(
          Colors.green,
          S.of(context).protectYourself,
          () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) => ProtectYourself())),
        ),
        PageButton(
          Colors.lightBlue,
          "Latest\nNumbers",
          () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) => ProtectYourself())),
        ),
        PageButton(
          Colors.amber,
          "Your\nQuestions\nAnswered",
          () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) => ProtectYourself())),
        ),
        PageButton(
            Colors.brown,
            S.of(context).whoMythBusters,
            () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (c) => WhoMythBusters()))),
      ],
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      padding: EdgeInsets.all(4.0),
    ));
  }
}

class PageButton extends StatelessWidget {
  const PageButton(this.backgroundColor, this.title, this.onPressed);

  final Color backgroundColor;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: backgroundColor,
      child: Center(
        child: Padding(
            padding: const EdgeInsets.all(4.0), child: Text(title, textAlign: TextAlign.center)),
      ),
      onPressed: this.onPressed,
    );
  }
}
