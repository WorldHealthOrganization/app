import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:who_app/constants.dart';

class PageHeader extends StatelessWidget {

  PageHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      backgroundColor: Colors.white,
      largeTitle: Text(this.title, style: TextStyle(color: Constants.primaryDark),),
      
    );
  }
}