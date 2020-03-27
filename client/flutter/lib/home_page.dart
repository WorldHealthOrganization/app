import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/page_button.dart';
import 'package:WHOFlutter/page_scaffold.dart';
import 'package:WHOFlutter/pages/protect_yourself.dart';
import 'package:WHOFlutter/pages/travel_advice.dart';
import 'package:WHOFlutter/pages/who_myth_busters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(2, 1),
];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        body: new StaggeredGridView.count(
      crossAxisCount: 2,
      staggeredTiles: _staggeredTiles,
      children: [
        PageButton(
          Colors.green,
          S.of(context).protectYourself,
          () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) => ProtectYourself())),
        ),
        PageButton(
          Colors.lightBlue,
          "Latest Numbers",
          () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) => ProtectYourself())),
        ),
        PageButton(
          Colors.amber,
          "Your Questions Answered",
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
      padding: const EdgeInsets.all(4.0),
    ));

    // PageButton(
    //     title: S.of(context).travelAdvice,
    //     onPressed: () => Navigator.of(context)
    //         .push(MaterialPageRoute(builder: (c) => TravelAdvice()))),
    // PageButton(
    //     title: S.of(context).shareTheApp,
    //     lightColor: true,
    //     onPressed: () => Share.share(
    //         'Check out the official COVID-19 Guide App https://www.who.int/covid-19-app')),
    // PageButton(
    //     title: S.of(context).aboutTheApp,
    //     lightColor: true,
    //     onPressed: () => showAboutDialog(
    //         context: context,
    //         applicationLegalese:
    //             "The official World Health Organization COVID-19 App.")),
  }
}

class PageButton extends StatelessWidget {
  const PageButton(this.backgroundColor, this.title, this.onPressed);

  final Color backgroundColor;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return new FlatButton(
      color: backgroundColor,
      child: new InkWell(
        onTap: this.onPressed,
        child: new Center(
          child: new Padding(
              padding: const EdgeInsets.all(4.0), child: new Text(title)),
        ),
      ),
    );
  }
}
