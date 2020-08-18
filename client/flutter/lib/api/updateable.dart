import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:who_app/api/user_preferences.dart';

abstract class Updateable {
  Future<void> update();
}

class PeriodicUpdater with WidgetsBindingObserver {
  final Updateable updateable;
  final WidgetsBinding binding;

  PeriodicUpdater({
    @required this.updateable,
    @required this.binding,
    bool installImmediately = false,
  }) {
    if (installImmediately) {
      install();
    }
  }

  void install() {
    print('installing $this');
    binding.addObserver(this);
  }

  void dispose() {
    print('disposing $this');
    binding.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _update();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        break;
    }
  }

  void _update() async {
    print('updating $this');
    // TODO: UserPreferences should be injected dependency.
    if (await UserPreferences().getTermsOfServiceCompleted()) {
      await updateable.update();
    }
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
