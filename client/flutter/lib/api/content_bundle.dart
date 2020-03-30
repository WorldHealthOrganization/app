import 'package:yaml/yaml.dart';

/// A localized YAML file loaded preferentially from the network, falling back
/// to a local asset.
class ContentBundle {
  dynamic yaml;

  ContentBundle.from(String yamlString) {
    this.yaml = loadYaml(yamlString);
  }

  int get schemaVersion {
    return _getInt('schema_version');
  }

  int get contentVersion {
    return _getInt('content_version');
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
