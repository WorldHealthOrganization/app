import 'package:flutter/material.dart';
import 'package:who_app/api/content/content_bundle.dart';
import 'package:who_app/api/linking.dart';
import 'package:who_app/api/content/content_loading.dart';
import 'dart:ui';
import 'package:meta/meta.dart';

typedef IndexDataSource = Future<IndexContent> Function(Locale);

/// Interpret a content bundle as Index data.
/// Index data contains a series of title and optional subtitle pairs each with an associated
/// link.
class IndexContent extends ContentBase {
  List<IndexItem> items;
  IndexPromo promo;

  static Future<IndexContent> learnIndex(Locale locale) async {
    var bundle = await ContentLoading().load(locale, "learn_index");
    return IndexContent(bundle);
  }

  IndexContent(ContentBundle bundle) : super(bundle, schemaName: "index") {
    try {
      final yamlPromo = bundle.contentPromo;
      if (yamlPromo != null) {
        this.promo = IndexPromo(
          buttonText: yamlPromo['button_text'],
          title: yamlPromo['title'],
          subtitle: yamlPromo['subtitle'],
          link: RouteLink.fromUri(yamlPromo['href']),
        );
      }
      this.items = bundle.contentItems
          .map((item) => IndexItem(
                title: item['title'],
                subtitle: item['subtitle'],
                link: RouteLink.fromUri(item['href']),
              ))
          .toList();
    } catch (err) {
      print("Error loading Index data: $err");
      throw ContentBundleDataException();
    }
  }
}

class IndexPromo {
  final String title;
  final String subtitle;
  final RouteLink link;
  final String buttonText;

  IndexPromo({
    @required this.title,
    @required this.subtitle,
    @required this.link,
    @required this.buttonText,
  });
}

class IndexItem {
  final String title;
  final String subtitle;
  final RouteLink link;

  IndexItem({
    @required this.title,
    @required this.subtitle,
    @required this.link,
  });
}
