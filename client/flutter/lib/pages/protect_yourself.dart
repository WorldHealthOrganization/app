import 'package:who_app/api/content/schema/fact_content.dart';
import 'package:who_app/components/dialogs.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/rive_animation.dart';
import 'package:who_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:who_app/generated/l10n.dart';

class ProtectYourself extends StatefulWidget {
  final FactsDataSource dataSource;

  const ProtectYourself({Key key, @required this.dataSource}) : super(key: key);

  @override
  _ProtectYourselfState createState() => _ProtectYourselfState();
}

class _ProtectYourselfState extends State<ProtectYourself> {
  final whoBlue = Color(0xFF3D8BCC);
  final header =
      TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w800);
  FactContent _factContent;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await _loadFacts();
  }

  // TODO: Move to a base class for "facts" based pages?
  Future _loadFacts() async {
    if (_factContent != null) {
      return;
    }
    Locale locale = Localizations.localeOf(context);
    try {
      _factContent = await widget.dataSource(locale);
      await Dialogs.showUpgradeDialogIfNeededFor(context, _factContent);
    } catch (err) {
      print("Error loading fact data: $err");
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        title: S.of(context).protectYourselfTitle,
        showShareBottomBar: false,
        announceRouteManually: true,
        body: [SliverList(delegate: SliverChildListDelegate(_buildCards()))]);
  }

  List<Widget> _buildCards() {
    return (_factContent?.items ?? []).map((fact) {
      print("fact body = ${fact.body}, image = ${fact.imageName}");
      return _ProtectYourselfCard(
        message: _message(fact.body),
        child: fact.animationName != null
            ? _getAnimation(fact.animationName)
            : _getSVG('assets/svg/${fact.imageName}.svg'),
      );
    }).toList();
  }

  Widget _getSVG(String svgAssetName) => AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: whoBlue,
          child: SvgPicture.asset(svgAssetName),
        ),
      );

  Widget _getAnimation(String animationName) => AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: whoBlue,
          child: RiveAnimation(
            'assets/animations/$animationName.flr',
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: 'Untitled',
          ),
        ),
      );

  // TODO: Change this to use HTML content styling like the other pages?
  Text _message(String input) {
    final TextStyle normal = TextStyle(
      color: Constants.textColor,
      fontSize: 16,
      height: 1.4,
    );
    final TextStyle bold = TextStyle(
      color: Constants.textColor,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    );
    // Make sections delineated by asterisk * bold. For example:
    // String text = '*This is bold* this is not';

    var regex = RegExp(r'\*([^,*]+)\*');

    var matched = regex.allMatches(input);

    var spans = <TextSpan>[];
    var before = 0;
    for (var match in matched) {
      var value = match.group(1);
      if (before < match.start) {
        spans.add(
          TextSpan(
            text: input.substring(before, match.start),
          ),
        );
      }

      spans.add(
        TextSpan(text: value, style: bold),
      );
      before = match.end;
    }

    spans.add(
      TextSpan(
        text: input.substring(before),
      ),
    );
    return Text.rich(
      TextSpan(style: normal, children: spans),
    );
  }
}

class _ProtectYourselfCard extends StatelessWidget {
  const _ProtectYourselfCard({
    @required this.message,
    @required this.child,
  });

  final Text message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
      ),
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: child,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: message,
            ),
          ],
        ),
      ),
    );
  }
}
