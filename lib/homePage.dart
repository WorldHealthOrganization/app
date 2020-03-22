import 'package:flutter/material.dart';
import './constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 20, left: 20, top: 50),
        child: Column(
          children: <Widget>[
            Image(
                image: AssetImage('assets/WHO.jpg'),
                width: MediaQuery.of(context).size.width),
            Container(
              padding: EdgeInsets.only(top: 50),
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                onPressed: () {},
                color: Constants.primaryColor,
                child: Text('Protect Yourself', textScaleFactor: 2,),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              height: 130,
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                onPressed: () {},
                color: Constants.primaryColor,
                child: Text('Check Your Health', textScaleFactor: 2,),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              height: 130,
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                onPressed: () {},
                color: Constants.primaryColor,
                child: Text('Local Maps', textScaleFactor: 2,),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              height: 130,
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                onPressed: () {},
                color: Constants.primaryColor,
                child: Text('Share the App', textScaleFactor: 2,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
