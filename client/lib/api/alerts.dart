import 'package:flutter/material.dart';

class Alert {
  final String title;
  final String body;
  final Color color;
  final bool dismissable;

  Alert(
    this.title,
    this.body, {
    this.color = Colors.red,
    this.dismissable = false,
  });
}
