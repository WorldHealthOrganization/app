import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:who_app/api/content/content_bundle.dart';
import 'package:who_app/api/content/content_store.dart';
import 'package:who_app/api/display_conditions.dart';

abstract class ContentWidget<T extends ContentBase> extends StatelessWidget {
  @protected
  final ContentStore dataSource;

  ContentWidget({Key key, @required this.dataSource}) : super(key: key);

  @protected
  T getContent();

  @override
  Widget build(_) {
    return Observer(
      builder: (context) {
        final content = getContent();
        final logicContext = dataSource.logicContext;
        print(
            '$this rebuild / ${hashCode} / content: ${content.hashCode} v${content?.bundle?.contentVersion} / logicContext: ${logicContext.hashCode}');
        return buildImpl(context, content, logicContext);
      },
    );
  }

  @protected
  Widget buildImpl(BuildContext context, T content, LogicContext logicContext);
}
