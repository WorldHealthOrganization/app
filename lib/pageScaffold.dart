import 'package:WHOFlutter/homePage.dart';
import 'package:flutter/material.dart';

class PageScaffold extends StatelessWidget {
  PageScaffold(this.body);
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
              GestureDetector(
                child: Image(
                    image: AssetImage('assets/WHO.jpg'),
                    width: MediaQuery.of(context).size.width),
                    onTap: ()=>Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c)=>HomePage()
                      )
                    ),
              ),
              Expanded(child: this.body)
            ])));
  }
}
