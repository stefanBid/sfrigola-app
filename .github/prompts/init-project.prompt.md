---
agent: agent
description: 'Initialise this template repo for a new project: update name, global rules and instruction files.'
---

# Workflow — Project Initialisation

> **Required mode: Agent.**
> If you do not have access to file system tools (you are in Ask Mode / Chat Mode), reply **only** with:
> "To run the project initialisation I need to be in **Agent** mode. Please re-send the request in Agent mode."
> Then stop. Do not attempt the workflow.

---

## Step 1 — Collect the three pieces of information

Use `vscode_askQuestions` to ask all three questions **in a single call**:

1. **Username** — Are you still the *Signore della UI*? If not, what name should I use?

2. **Global rules** — Re-read the `.github/copilot-instructions.md` file of the current project.
   Are there any global rules to add, change or remove compared to the template version?
   (If there are no changes, write "no changes".)

3. **Project name** — What is the new project called? (e.g. `MyApp`, `RecipeBook`, `FitnessTracker`)

4. **App context** — Describe briefly what the app does and who it is for (2–4 sentences max). This will be stored as permanent context and used to give you more relevant UI, UX and technical suggestions aligned with the app's domain. (e.g. "A recipe management app for home cooks. Users browse recipes, filter by ingredient and save favourites. The visual style should feel warm and food-oriented.")

Do not proceed until you have received answers to all four questions.

---

## Step 2 — Apply configuration changes

### 2a. Update the username in `copilot-instructions.md`

If the username has changed, replace in `.github/copilot-instructions.md`:
- The `## Identifier name:` line with the new identifier
- Every occurrence of `Signore della UI` / `Signore delle UI` with the new name

### 2b. Add / modify global rules in `copilot-instructions.md`

If the user has provided new rules, add them to the appropriate section of the file without deleting existing ones unless explicitly requested.

### 2c. Save the app context in `copilot-instructions.md`

Add (or replace if already present) an `## App context` section at the top of `.github/copilot-instructions.md`, right after the frontmatter title, with the text provided by the user. Example:

```markdown
## App context

A recipe management app for home cooks. Users browse recipes, filter by ingredient and save favourites. The visual style should feel warm and food-oriented.
```

This section is used as persistent domain context: refer to it whenever making UI, UX or architectural suggestions to keep them aligned with the app's purpose and audience.

---

### 2d. Reset the project version

Set the version in `pubspec.yaml` to `1.0.0+1`:

Replace the `version:` line with:
```yaml
version: 1.0.0+1
```

Also reset the version badge in `README.md` to `1.0.0` if a badge is present.

### 2e. Reset or create the CHANGELOG

Check whether `CHANGELOG.md` exists:

- **If it exists and has content**: delete all existing entries and replace the entire file content with a clean skeleton using `dart run cider release 1.0.0`. Before running the command, ensure the `[Unreleased]` section is empty (no leftover log entries from previous runs). The result must be a CHANGELOG that starts from `1.0.0` with today's date and no prior history.
- **If it does not exist**: cider will create it automatically on first use — no manual action needed.

> The CHANGELOG must always be in sync with the reset version (`1.0.0`). Never carry over entries from the template or from a previous project's history.

---

### 2e. Rename the project

Starting from the provided name (e.g. `RecipeBook`), apply these changes:

| File | Field | Value |
|---|---|---|
| `pubspec.yaml` | `name:` | snake_case of the name (e.g. `recipe_book`) |
| `lib/main.dart` | `title:` inside `MaterialApp.router` | The name as-is (e.g. `'RecipeBook'`) |
| `android/app/src/main/AndroidManifest.xml` | `android:label` | The name as-is |
| `ios/Runner/Info.plist` | `CFBundleName` and `CFBundleDisplayName` | The name as-is |

> Always use `read_file` before editing to find the exact string to replace.

---

## Step 3 — Analyse the `lib/` directory

Analyse the entire `lib/` directory down to every sub-level:

```
lib/
  helpers/        → design system tokens, validators, utilities
  layouts/        → reusable page layouts
  models/         → data models
  screens/        → feature screens
  services/       → business logic and API
  widgets/        → reusable UI components
```

For each area, verify that the corresponding **instruction files** are up to date:

| Directory | Instruction file |
|---|---|
| `lib/helpers/` | `.github/instructions/helpers.instructions.md` |
| `lib/screens/` | `.github/instructions/screens.instructions.md` |
| `lib/widgets/` | `.github/instructions/widgets.instructions.md` |
| `lib/router.dart` or routing | `.github/instructions/routing.instructions.md` |
| any `.dart` file | `.github/instructions/design-system.instructions.md` |

### What to check for each instruction file

- Are there **new widgets** in `lib/widgets/` not documented in the instruction?
- Are there **new helpers** or tokens in `lib/helpers/` missing from the design-system?
- Are there **new screens** with patterns not covered by `screens.instructions.md`?
- Are there **obsolete entries** mentioned in the instructions but no longer present in the code?
- Does the **project deviate** from the stack or conventions described in `copilot-instructions.md`?

### What to do

- **Update** the instruction files to add or remove sections based on the actual state of `lib/`
- **Do not delete** general rules or design system tokens if they are still valid
- **Report** any relevant discrepancy to the user before applying changes to instruction files (a brief list is enough), then proceed

---

## Step 4 — Final report

At the end, provide a concise report in Italian with:

- Username set
- Project name set
- Renamed / updated files
- Modified instruction files and their main changes
- Any inconsistencies found but not automatically resolved (things that require user intervention)
