import 'package:WHOFlutter/pages.dart';
import 'package:WHOFlutter/utils/page_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Router {
  static RouteFactory routes() {
    return (settings) {
      var name = settings.name;
      var args = settings.arguments;

      Widget screen;

      switch (name) {
        case INITIAL_ROUTE:
          screen = HomePage();
          break;

        case PROTECT_YOURSELF_ROUTE:
          screen = ProtectYourself();
          break;

        case WHO_MYTH_BUSTERS_ROUTE:
          screen = WhoMythBusters();
          break;

        case TRAVEL_ADVICE_ROUTE:
          screen = TravelAdvice();
          break;

        default:
          screen = HomePage();
          break;
      }

      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }
}
