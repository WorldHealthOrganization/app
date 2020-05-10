## Client Flutter implementations

### Structure

- `app/` - Production mobile application.
- `app_en/` - Development-only mobile application with exposure notification. This is experimental work that is not currently used within the production app. We are actively investigating the Apple / Google exposure notification protocol and will share more information in the future.
- `exposure_notifications/` - Flutter plugin that integrates with the platform-specific EN protocol.
