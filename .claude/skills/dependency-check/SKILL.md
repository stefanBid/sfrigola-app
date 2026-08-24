---
name: dependency-check
description: Check for outdated dependencies in the Sfrigola app and classify safe vs breaking updates. Use when asked to check, update, or audit dependencies.
---

Run `flutter pub outdated`. Classify updates:
- Safe (same major) → edit `pubspec.yaml` constraints, then `flutter pub get`.
- Breaking (major bump) → report to user with pub.dev changelog URL.
