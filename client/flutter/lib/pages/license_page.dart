// BASED OFF OF FLUTTER'S about.dart file
// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Originally from:
// https://github.com/flutter/flutter/blob/fef2d6ccd6050298e498ea77a11d820aaeb4d087/packages/flutter/lib/src/material/about.dart

import 'dart:async';
import 'dart:developer' show Timeline, Flow;

import 'package:flutter/cupertino.dart' hide Flow;
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import 'package:who_app/components/page_scaffold/page_scaffold.dart';

class LicensePage extends StatefulWidget {
  const LicensePage();
  @override
  _LicensePageState createState() => _LicensePageState();
}

class _LicensePageState extends State<LicensePage> {
  @override
  void initState() {
    super.initState();
    _initLicenses();
  }

  final List<Widget> _licenses = <Widget>[];
  bool _loaded = false;

  Future<void> _initLicenses() async {
    var debugFlowId = -1;
    assert(() {
      final flow = Flow.begin();
      Timeline.timeSync('_initLicenses()', () {}, flow: flow);
      debugFlowId = flow.id;
      return true;
    }());
    await for (final LicenseEntry license in LicenseRegistry.licenses) {
      if (!mounted) {
        return;
      }
      assert(() {
        Timeline.timeSync('_initLicenses()', () {},
            flow: Flow.step(debugFlowId));
        return true;
      }());
      final paragraphs =
          await SchedulerBinding.instance.scheduleTask<List<LicenseParagraph>>(
        license.paragraphs.toList,
        Priority.animation,
        debugLabel: 'License',
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _licenses.add(SizedBox(
          height: 32,
        ));
        _licenses.add(Container(
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(width: 0.0))),
          child: Text(
            license.packages.join(', '),
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ));
        for (final paragraph in paragraphs) {
          if (paragraph.indent == LicenseParagraph.centeredIndent) {
            _licenses.add(Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                paragraph.text,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ));
          } else {
            assert(paragraph.indent >= 0);
            _licenses.add(Padding(
              padding: EdgeInsetsDirectional.only(
                  top: 8.0, start: 16.0 * paragraph.indent),
              child: Text(paragraph.text),
            ));
          }
        }
      });
    }
    setState(() {
      _loaded = true;
    });
    assert(() {
      Timeline.timeSync('Build scheduled', () {}, flow: Flow.end(debugFlowId));
      return true;
    }());
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Licenses',
      body: [
        SliverPadding(
          padding: EdgeInsets.all(24.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(height: 18.0),
                Text(
                  'Powered by Flutter',
                  textAlign: TextAlign.center,
                ),
                Container(height: 24.0),
                ..._licenses,
                if (!_loaded)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
