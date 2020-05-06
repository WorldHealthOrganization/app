package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import org.who.exposure_notifications.ExposureNotificationsPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    ExposureNotificationsPlugin.registerWith(registry.registrarFor("org.who.exposure_notifications.ExposureNotificationsPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
