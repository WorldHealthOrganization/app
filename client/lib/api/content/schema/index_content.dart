import 'package:flutter/material.dart';
import 'package:who_app/api/content/content_bundle.dart';
import 'package:who_app/api/content/schema/conditional_content.dart';
import 'package:who_app/api/linking.dart';
import 'dart:ui';
import 'package:meta/meta.dart';

typedef IndexDataSource = Future<IndexContent> Function(Locale);

/// Interpret a content bundle as Index data.
/// Index data contains a series of title and optional subtitle pairs each with an associated
/// link.
class IndexContent extends ContentBase {
  List<IndexItem> items;
  List<IndexPromo> promos;

  IndexContent(ContentBundle bundle) : super(bundle, schemaName: 'index') {
    try {
      final yamlPromos = bundle.contentPromos;
      if (yamlPromos != null) {
        promos = bundle.contentPromos
            .map((yamlPromo) => IndexPromo(
                  promoType: yamlPromo['promo_type'],
                  buttonText: yamlPromo['button_text'],
                  title: yamlPromo['title'],
                  subtitle: yamlPromo['subtitle'],
                  link: RouteLink.fromUri(yamlPromo['href']),
                  imageName: yamlPromo['image_name'],
                  displayCondition: yamlPromo['display_condition'],
                ))
            .toList();
      }
      items = bundle.contentItems
          .map((item) => IndexItem(
                itemType: item['item_type'],
                title: item['title'],
                subtitle: item['subtitle'],
                link: RouteLink.fromUri(item['href']),
                buttonText: item['button_text'],
                imageName: item['image_name'],
                displayCondition: item['display_condition'],
              ))
          .toList();
    } catch (err) {
      print('Error loading Index data: $err');
      throw ContentBundleDataException();
    }
  }
}

enum IndexPromoType { CheckYourSymptoms, ProtectYourself, DefaultType }

class IndexPromo with ConditionalItem {
  final String promoType;
  final String title;
  final String subtitle;
  final RouteLink link;
  final String buttonText;
  final String imageName;
  @override
  final String displayCondition;

  IndexPromo({
    @required this.title,
    @required this.subtitle,
    @required this.link,
    @required this.buttonText,
    this.imageName,
    this.promoType,
    this.displayCondition,
  });

  IndexPromoType get type {
    switch (promoType) {
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
  menu_list_tile,
  unknown,
}

class IndexItem with ConditionalItem {
  final String itemType;
  final String title;
  final String subtitle;
  final RouteLink link;
  final String buttonText;
  final String imageName;
  @override
  final String displayCondition;

  IndexItem({
    this.itemType,
    this.title,
    this.subtitle,
    this.link,
    this.buttonText,
    this.imageName,
    this.displayCondition,
  });

  IndexItemType get type {
    switch (itemType) {
      case 'recent_numbers':
        return IndexItemType.recent_numbers;
      case 'protect_yourself':
        return IndexItemType.protect_yourself;
      case 'information_card':
        return IndexItemType.information_card;
      case 'menu_list_tile':
        return IndexItemType.menu_list_tile;
    }
    return IndexItemType.unknown;
  }
}
