import 'package:WHOFlutter/components/page_button.dart';
import 'package:flutter/material.dart';

class LocationSharing extends StatefulWidget {
  @override
  _LocationSharingState createState() => _LocationSharingState();
}

class _LocationSharingState extends State<LocationSharing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Image.asset("assets/WHO.jpg"),
              Spacer(),
              PageButton(
                Color(0xff3b8bc4),
                "Allow Location Sharing",
                _allowLocationSharing,
                titleStyle: TextStyle(),
                centerVertical: true,
                centerHorizontal: true,
              ),
              SizedBox(height: 16),
              FlatButton(
                child: Text(
                  "Skip",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: _skipLocationSharing,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void _allowLocationSharing() async {
    _complete();
  }

  void _skipLocationSharing() async {
    _complete();
  }

  void _complete() async {
    Navigator.of(context).pop();
  }
}
