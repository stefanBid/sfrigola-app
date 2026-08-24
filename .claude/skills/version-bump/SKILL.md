---
name: version-bump
description: Bump the Sfrigola app version using cider. Use when asked to update the project to version X.Y.Z (e.g. "aggiornami il progetto alla versione X.Y.Z").
---

Trigger: "aggiornami il progetto alla versione X.Y.Z"

- Never apply a build number (`+N`) manually — it is managed by CI/CD.
- Use `dart run cider bump patch|minor|major` then `dart run cider release X.Y.Z`.
- Update version badge in `README.md`.
- Ask user before writing CHANGELOG entries.
