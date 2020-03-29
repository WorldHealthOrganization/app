import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

/// Shows all contributors stored in `credits.yaml` under the `team` key.
class Contributors extends StatelessWidget {
  const Contributors({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contributors'),
      ),
      body: const _CreditsList(yamlKey: 'team'),
    );
  }
}

/// Shows all supporters stored in `credits.yaml` under the `supporters` key.
class Supporters extends StatelessWidget {
  const Supporters({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supporters'),
      ),
      body: const _CreditsList(yamlKey: 'supporters'),
    );
  }
}

/// Shows a list that is stored inside of `credits.yaml` with the given [yamlKey].
class _CreditsList extends StatefulWidget {
  const _CreditsList({
    Key key,
    this.yamlKey,
  }) : super(key: key);

  final String yamlKey;

  @override
  State createState() => _CreditsListState();
}

class _CreditsListState extends State<_CreditsList> {
  List<String> _entries;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _entries = [];
    _loadList(DefaultAssetBundle.of(context));
  }

  Future<void> _loadList(AssetBundle assetBundle) async {
    List<String> result = [];

    try {
      final parsedYaml =
          loadYaml(await assetBundle.loadString('../../content/credits.yaml'));

      result.addAll((parsedYaml[widget.yamlKey] as YamlList).cast<String>());
    } catch (_) {
      result.add('error');
    }

    setState(() {
      _entries.addAll(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        for (final entry in _entries)
          ListTile(
            title: Text(entry),
          ),
      ],
    );
  }
}
