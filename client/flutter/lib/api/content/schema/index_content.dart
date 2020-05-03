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

  static Future<IndexContent> homeIndex(Locale locale) async {
    var bundle = await ContentLoading().load(locale, "home_index");
    return IndexContent(bundle);
  }

  static Future<IndexContent> learnIndex(Locale locale) async {
    var bundle = await ContentLoading().load(locale, "learn_index");
    return IndexContent(bundle);
  }

  IndexContent(ContentBundle bundle) : super(bundle, schemaName: "index") {
    try {
      final yamlPromo = bundle.contentPromo;
      if (yamlPromo != null) {
        this.promo = IndexPromo(
          promoType: yamlPromo['promo_type'],
          buttonText: yamlPromo['button_text'],
          title: yamlPromo['title'],
          subtitle: yamlPromo['subtitle'],
          link: RouteLink.fromUri(yamlPromo['href']),
        );
      }
      this.items = bundle.contentItems
          .map((item) => IndexItem(
                itemType: item['item_type'],
                title: item['title'],
                subtitle: item['subtitle'],
                link: RouteLink.fromUri(item['href']),
                buttonText: item['button_text'],
              ))
          .toList();
    } catch (err) {
      print("Error loading Index data: $err");
      throw ContentBundleDataException();
    }
  }
}

enum IndexPromoType { CheckYourSymptoms, ProtectYourself, DefaultType }

class IndexPromo {
  final String promoType;
  final String title;
  final String subtitle;
  final RouteLink link;
  final String buttonText;

  IndexPromo({
    @required this.title,
    @required this.subtitle,
    @required this.link,
    @required this.buttonText,
    this.promoType,
  });

  IndexPromoType get type {
    switch (this.promoType) {
      case 'check_your_symptoms':
        return IndexPromoType.CheckYourSymptoms;
      case 'protect_yourself':
        return IndexPromoType.ProtectYourself;
    }
    return IndexPromoType.DefaultType;
  }
}

enum IndexItemType {
  recent_numbers,
  protect_yourself,
  information_card,
  unknown
}

class IndexItem {
  final String itemType;
  final String title;
  final String subtitle;
  final RouteLink link;
  final String buttonText;

  IndexItem({
    this.itemType,
    this.title,
    this.subtitle,
    this.link,
    this.buttonText,
  });

  IndexItemType get type {
    switch (this.itemType) {
      case 'recent_numbers':
        return IndexItemType.recent_numbers;
      case 'protect_yourself':
        return IndexItemType.protect_yourself;
      case 'information_card':
        return IndexItemType.information_card;
    }
    return IndexItemType.unknown;
  }
}
