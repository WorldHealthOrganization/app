import 'package:flutter/cupertino.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';

import 'package:exposure_notifications/exposure_notifications.dart';

class ExposuresPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      disableBackButton: true,
      headingBorderColor: Color(0x0),
      title: "Exposures",
      body: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            FutureBuilder(
                future: ExposureNotifications.platformVersion,
                builder: (ctx, data) => Text(data?.data ?? "-")),
          ]),
        )
      ],
    );
  }
}
