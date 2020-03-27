import 'package:flutter/material.dart';

class PageScaffold extends StatelessWidget {
  final Widget body;
  final EdgeInsetsGeometry bodyPadding;

  PageScaffold(
      {@required this.body,
      this.bodyPadding = const EdgeInsets.symmetric(horizontal: 24)});

  Widget logo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 0, left: 24, right: 24),
      child: Image(
        image: AssetImage('assets/WHO.jpg'),
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: <Widget>[
        logo(context),
        Material(
          type: MaterialType.transparency,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IgnorePointer(
                // This is just used for positioning the body correctly.
                child: Opacity(
                  // An opacity of 0 ensures that only layout and not paint is called (the widget is not drawn).
                  opacity: 0,
                  child: logo(context),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: bodyPadding,
                  child: this.body,
                ),
              ),
            ],
          ),
        ),
      ]),
    ));
  }
}
