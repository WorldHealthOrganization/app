import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class Updateable {
  Future<void> update();
}

class PeriodicUpdater with WidgetsBindingObserver {
  final Updateable updateable;
  final WidgetsBinding binding;
  final bool updateOnAppSwitch;
  final bool updateOnConnectivityChange;

  StreamSubscription<ConnectivityResult> connectivitySub;

  PeriodicUpdater({
    @required this.updateable,
    @required this.binding,
    bool installImmediately = false,
    this.updateOnAppSwitch = true,
    this.updateOnConnectivityChange = true,
  }) {
    if (installImmediately) {
      install();
    }
  }

  void install() {
    print('installing $this');
    if (updateOnAppSwitch) {
      binding.addObserver(this);
    }

    if (updateOnConnectivityChange) {
      assert(connectivitySub == null);
      connectivitySub = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        _update();
      });
    }
  }

  void dispose() {
    print('disposing $this');
    if (updateOnAppSwitch) {
      binding.removeObserver(this);
    }

    if (connectivitySub != null) {
      connectivitySub.cancel();
      connectivitySub = null;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (updateOnAppSwitch) {
          _update();
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        break;
    }
  }

  void _update() async {
    print('updating $this');
    await updateable.update();
  }

  @override
  String toString() {
    return '${super.toString()}<${updateable.runtimeType}>';
  }

  static ProxyProvider<T, PeriodicUpdater> asProvider<T extends Updateable>() {
    return ProxyProvider<T, PeriodicUpdater>(
      lazy: false,
      update: (_, t, __) => PeriodicUpdater(
          updateable: t,
          binding: WidgetsBinding.instance,
          installImmediately: true),
      dispose: (_, pu) => pu.dispose(),
    );
  }
}
