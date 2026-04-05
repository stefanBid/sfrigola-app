---
agent: agent
description: 'Update README.md to reflect the current state of the codebase.'
---

# Workflow — Update Documentation

> **Required mode: Agent.**
> If you do not have access to file system tools (you are in Ask Mode / Chat Mode), reply **only** with:
> "To update the documentation I need to be in **Agent** mode. Please re-send the request in Agent mode."
> Then stop. Do not attempt the workflow.

---

## Step 1 — Read the current state

Read all of the following in parallel before writing anything:

- `README.md` (current content)
- `pubspec.yaml` (project name, version, dependencies)
- `.github/copilot-instructions.md` (app context, stack, conventions)
- `lib/` directory structure (all sub-levels)
- All files in `lib/helpers/`, `lib/widgets/`, `lib/layouts/`
- `lib/router.dart`
- All instruction files under `.github/instructions/`

---

## Step 2 — Identify differences

Compare what is documented in `README.md` against the actual codebase. Note:

- Sections that are outdated or no longer accurate
- Missing sections (new widgets, helpers, screens, conventions not yet documented)
- Incorrect project name, version or stack information
- Broken or missing links

Report the list of differences to the user with a brief summary, then proceed without waiting for approval.

---

## Step 3 — Rewrite README.md

Rewrite `README.md` entirely, structured as a proper documentation book. Writing language: **English**.

### Required structure

```
# [Project Name]
> One-line description from App context

[Version badge]  [Flutter badge]  [License badge]

---

## Table of Contents
1. Overview
2. Getting Started
3. Project Structure
4. Design System
5. Routing
6. Screens
7. Widgets
8. Helpers & Validators
9. AI Tooling — Prompts & Instructions
10. Deployment
11. Dependencies

---

## 1. Overview
[Expanded app context, purpose, audience, visual tone]

## 2. Getting Started
### Prerequisites
### Installation
### Project Initialisation

## 3. Project Structure
[Annotated directory tree of lib/]

## 4. Design System
### Colours — AppColors
### Typography — AppTypography
### Spacing & Radius — AppDesign
### Icons — PhosphorIcons

## 5. Routing
### AppRouter
### Adding a new route (3-step workflow)

## 6. Screens
### Conventions
### Available screens
[One subsection per feature folder found in lib/screens/]

## 7. Widgets
### Placement rules
[One subsection per widget found in lib/widgets/, with props table]

## 8. Helpers & Validators
[One subsection per file found in lib/helpers/]

## 9. AI Tooling — Prompts & Instructions

> ⚠️ This section is MANDATORY and must always be present. Never remove or omit it when updating documentation.

### How GitHub Copilot is configured
Explain that this repo ships with pre-configured Copilot context:
- `.github/copilot-instructions.md` — global rules, app context, response language, identifier name
- `.github/instructions/*.instructions.md` — scoped rules loaded automatically per file type
- `.github/prompts/*.prompt.md` — reusable Agent-mode workflows

### Available prompts
List every `.prompt.md` file found under `.github/prompts/` with:
- Filename (as a code span)
- Trigger phrase (from the `description` frontmatter field)
- One-line description of what it does

Format as a table:
| Prompt file | Trigger | What it does |
|---|---|---|

### How to run a prompt
Explain step by step how a user opens the Copilot Chat panel in VS Code, switches to Agent mode, and calls a prompt — either by typing the trigger phrase or by referencing the file with `#` syntax.

### Instruction files
List every `.instructions.md` file under `.github/instructions/` with its `applyTo` pattern and a one-line description of what it governs.

## 10. Deployment

> ⚠️ This section is MANDATORY and must always be present. Never remove or omit it when updating documentation.

### iOS

#### Test distribution (TestFlight)
Step-by-step instructions:
1. Bump version/build with `bump-version` prompt
2. `flutter build ipa --release`
3. Open `build/ios/archive/Runner.xcarchive` in Xcode Organizer
4. Distribute → App Store Connect → TestFlight
5. Invite internal / external testers from App Store Connect

#### Production release (App Store)
1. Ensure version and build number are correct
2. `flutter build ipa --release`
3. Upload via Xcode Organizer → Distribute → App Store Connect
4. Complete metadata, screenshots and review information on App Store Connect
5. Submit for review

### Android

#### Test distribution (Internal Testing / Firebase App Distribution)
1. Bump version/build with `bump-version` prompt
2. `flutter build appbundle --release` (preferred) or `flutter build apk --release`
3. **Google Play** → Internal Testing track → upload `.aab`
4. **Firebase App Distribution** (alternative) → upload `.apk` and invite testers

#### Production release (Google Play)
1. Ensure `versionName` and `versionCode` are correct in `pubspec.yaml`
2. Sign the bundle: configure `key.properties` and `android/app/build.gradle` keystore block
3. `flutter build appbundle --release`
4. Upload to Google Play Console → Production track
5. Complete store listing, content rating and submit for review

### Signing & secrets
- Never commit keystore files or `key.properties` to version control
- Add them to `.gitignore` before the first commit
- Store secrets in environment variables or a secrets manager (e.g. GitHub Secrets for CI)

## 11. Dependencies
[Table: package | version | purpose]
```

### Rules

- Every chapter must have a short introductory paragraph before any subsections
- Props tables use three columns: `Prop`, `Type`, `Description`
- Version badge must reflect the current version in `pubspec.yaml`
- Flutter badge should link to flutter.dev
- Anchor links in the Table of Contents must work on GitHub Markdown
- Do not invent information — if something is not verifiable from the code, omit it or mark it as TBD
- **Sections 9 (AI Tooling) and 10 (Deployment) are mandatory** — they must always be present regardless of what else changes in the README. Never omit them.

---

## Step 4 — Write the file

Overwrite `README.md` with the new content.

Then confirm to the user in Italian with:
- A brief summary of what changed
- Any sections marked as TBD that need their input
