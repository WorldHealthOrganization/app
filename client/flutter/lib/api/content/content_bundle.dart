import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:yaml/yaml.dart';

/// A localized YAML file loaded preferentially from the network, falling back
/// to a local asset.
class ContentBundle {
  static int maxSupportedSchemaVersion = 1;
  dynamic yaml;

  // If true indicates that a version of this content is available in a schema
  // version newer than is supported by the loader.
  bool unsupportedSchemaVersionAvailable = false;

  /// Construct a bundle from utf-8 bytes containing YAML
  ContentBundle.fromBytes(Uint8List bytes,
      {bool unsupportedSchemaVersionAvailable = false}) {
    var yamlString = Encoding.getByName('utf-8').decode(bytes);
    _init(yamlString,
        unsupportedSchemaVersionAvailable: unsupportedSchemaVersionAvailable);
  }

  /// Construct a bundle from a utf-8 string containing YAML
  ContentBundle.fromString(String yamlString,
      {bool unsupportedSchemaVersionAvailable = false}) {
    _init(yamlString,
        unsupportedSchemaVersionAvailable: unsupportedSchemaVersionAvailable);
  }

  void _init(String yamlString,
      {bool unsupportedSchemaVersionAvailable = false}) {
    yaml = loadYaml(yamlString);
    unsupportedSchemaVersionAvailable = unsupportedSchemaVersionAvailable;
    if (schemaVersion > maxSupportedSchemaVersion) {
      throw ContentBundleSchemaVersionException();
    }
  }

  int get schemaVersion {
    return getInt('schema_version');
  }

  int get contentVersion {
    return getInt('content_version');
  }

  String get contentType {
    try {
      return yaml['contents']['type'];
    } catch (err) {
      return null;
    }
  }

  /// For content types containing a primary list of items, return the items.
  YamlList get contentItems {
    try {
      return yaml['contents']['items'];
    } catch (err) {
      return YamlList();
    }
  }

  YamlList get contentResults {
    try {
      return yaml['contents']['results'];
    } catch (err) {
      return YamlList();
    }
  }

  YamlList get contentCards {
    try {
      return yaml['contents']['results_cards'];
    } catch (err) {
      return YamlList();
    }
  }

  YamlList get contentPromos {
    try {
      return yaml['contents']['promos'];
    } catch (err) {
      return YamlList();
    }
  }

  String getString(String key) {
    try {
      return (yaml['contents'][key]).trim();
    } catch (err) {
      return null;
    }
  }

  int getInt(String key, {int orDefault = -1}) {
    try {
      return yaml[key];
    } catch (err) {
      return orDefault;
    }
  }
}

/// Base class for classes that interpret content bundle localized data
/// according to specific schema types.
class ContentBase {
  ContentBundle bundle;

  ContentBase(this.bundle, {@required String schemaName}) {
    if (bundle.contentType != schemaName) {
      throw Exception('Unsupported content type: ${bundle.contentType}');
    }
  }
}

/// Indicates an error in the expected content bundle schema version.
class ContentBundleSchemaVersionException implements Exception {}

/// Indicates an error interpreting the content bundle data according to the expected schema.
class ContentBundleDataException implements Exception {}
