import 'dart:convert';
import 'dart:typed_data';

import 'package:yaml/yaml.dart';

/// A localized YAML file loaded preferentially from the network, falling back
/// to a local asset.
class ContentBundle {
  static int maxSupportedSchemaVersion = 1;
  dynamic yaml;

  /// Construct a bundle from utf-8 bytes containing YAML
  ContentBundle.fromBytes(Uint8List bytes) {
    String yamlString = Encoding.getByName('utf-8').decode(bytes);
    _init(yamlString);
  }

  /// Construct a bundle from a utf-8 string containing YAML
  ContentBundle.fromString(String yamlString) {
    _init(yamlString);
  }

  void _init(String yamlString) {
    this.yaml = loadYaml(yamlString);
    if (schemaVersion > maxSupportedSchemaVersion) {
      throw ContentBundleVersionException();
    }
  }

  int get schemaVersion {
    return _getInt('schema_version');
  }

  int get contentVersion {
    return _getInt('content_version');
  }

  String get contentType {
    try {
      return yaml['contents']['type'];
    } catch (err) {
      return null;
    }
  }

  YamlList get contents {
    try {
      return yaml['contents']['items'];
    } catch (err) {
      return YamlList();
    }
  }

  int _getInt(String key, {int orDefault = -1}) {
    return yaml[key];
  }
}

class ContentBundleVersionException implements Exception {}
