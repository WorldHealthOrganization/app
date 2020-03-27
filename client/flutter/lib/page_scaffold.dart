import 'package:WHOFlutter/settings.dart';
import 'package:flutter/material.dart';

class PageScaffold extends StatelessWidget {
  final Widget body;
  final EdgeInsetsGeometry bodyPadding;

  PageScaffold({
    @required this.body,
    this.bodyPadding = const EdgeInsets.symmetric(horizontal: 24),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 24.0, bottom: 0, left: 24, right: 24),
                    child: Image(
                        image: AssetImage('assets/WHO.jpg'),
                        width: MediaQuery.of(context).size.width),
                  ),
                  IconButton(icon: Icon(Icons.settings),onPressed: () {

                    Navigator.of(context).push(MaterialPageRoute(fullscreenDialog: true,builder: (BuildContext context) {
                      return Settings();
                    }));
                  },),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: bodyPadding,
                  child: this.body,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
