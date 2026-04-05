---
agent: agent
description: 'Check for outdated packages, auto-update safe ones, list breaking changes for review.'
---

# Workflow — Dependency Check & Update

> **Required mode: Agent.**
> If you do not have access to file system tools (you are in Ask Mode / Chat Mode), reply **only** with:
> "To check dependencies I need to be in **Agent** mode. Please re-send the request in Agent mode."
> Then stop. Do not attempt the workflow.

---

## Step 1 — Read current dependencies

Read `pubspec.yaml` to get the full list of declared dependencies and dev_dependencies with their current version constraints.

---

## Step 2 — Check for outdated packages

Run the following command in the terminal:

```
flutter pub outdated
```

Parse the output. For each outdated package, note:
- **Current** — version currently in use
- **Upgradable** — version reachable by `flutter pub upgrade` within existing constraints
- **Resolvable** — version reachable by relaxing constraints in `pubspec.yaml`
- **Latest** — the latest published version

---

## Step 3 — Categorise updates

Classify each outdated package into one of two categories:

### Safe to update automatically
Criteria: the **resolvable** version has the **same major version** as the current one (minor or patch bump only). These updates follow semantic versioning and should not contain breaking API changes.

### Needs your attention
Criteria: the **resolvable** or **latest** version has a **different major version** than the current one. These may include breaking changes, removed APIs, new required configuration or migration steps.

---

## Step 4 — Apply safe updates

For each **direct** dependency in the "safe" category:
1. Edit `pubspec.yaml` directly — update the version constraint to match the new resolvable version (e.g. `^2.1.0` → `^2.3.0`). This is **mandatory**: do not skip it.
2. After updating all constraints in `pubspec.yaml`, run `flutter pub get` once to resolve and lock the new versions.

> **Important**: do NOT use `flutter pub upgrade` as a substitute for editing `pubspec.yaml`. The upgrade command only updates `pubspec.lock` without changing the declared constraints. Always update `pubspec.yaml` first.

---

## Step 5 — Report to the user

Provide a concise report in Italian:

### Aggiornamenti applicati automaticamente
| Pacchetto | Versione precedente | Versione aggiornata |
|---|---|---|
| … | … | … |

### Aggiornamenti che richiedono la tua attenzione
| Pacchetto | Versione attuale | Ultima versione | Note |
|---|---|---|---|
| … | … | … | Major bump — verifica il changelog prima di aggiornare |

> For each package needing attention, include the pub.dev changelog URL:
> `https://pub.dev/packages/[package_name]/changelog`

If no updates are available, say so clearly and confirm the project is up to date.
