---
applyTo: "**/*.dart"
---

# Design System — Helpers

Helpers are the single source of truth for the design system. **Every widget or screen MUST use them.** Never hardcode colours, font sizes, spacing or border radius.

---

## AppColors — `lib/helpers/app_colors.dart`

Access: `AppColors.of(context)` for adaptive colours, `AppColors.primary` etc. for static constants.

| Token | Light | Dark | Usage |
|---|---|---|---|
| `background` | `#F5FAFE` | `#0B1E30` | Page background |
| `surface` | `#DAECF8` | `#163350` | Cards, elevated containers |
| `text` | `#0D2137` | `#E8F3FB` | Primary text |
| `muted` | `#6B8DA8` | `#4D7A9E` | Secondary text, placeholders |
| `bottomBar` | `#EAF4FC` | `#0E2840` | Bottom navigation bar |
| `primary` | `#60C9F8` | — | Primary accent (static) |
| `secondary` | `#0A599C` | — | Secondary accent (static) |
| `error` | `#B00020` | — | Errors (static) |
| `success` | `#10B981` | — | Success (static) |
| `warning` | `#F59E0B` | — | Warning (static) |

Accent rule for buttons:
```dart
final accent = AppColors.of(context).isDark ? AppColors.secondary : AppColors.primary;
```

### Which colour and where

| Context | Token |
|---|---|
| Page/screen background | `AppColors.of(context).background` |
| Card, container, input background | `AppColors.of(context).surface` |
| Primary text (titles, body) | `AppColors.of(context).text` |
| Secondary text, placeholder, muted label | `AppColors.of(context).muted` |
| Accent colour for button/active icon | `AppColors.primary` (light) / `AppColors.secondary` (dark) |
| Error message, invalid field border | `AppColors.error` |
| Positive feedback / success | `AppColors.success` |
| Warning feedback | `AppColors.warning` |
| Bottom navigation bar background | `AppColors.of(context).bottomBar` |

---

## AppTypography — `lib/helpers/app_typography.dart`

Access: `AppTypography.of(context).{style}`. Font is **Lato** (Google Fonts).

| Style | Size | Weight | Usage |
|---|---|---|---|
| `heading1` | 28 | bold | Main screen titles |
| `heading2` | 22 | bold | Section titles |
| `heading3` | 18 | semibold | Subtitles |
| `heading4` | 16 | semibold | Card titles, list item titles |
| `body` | 16 | normal | Body text |
| `bodyMedium` | 14 | normal | Inputs, dense UI |
| `bodySecondary` | 16 | normal | Secondary text (colour `muted`) |
| `caption` | 12 | normal | Labels, secondary info |
| `small` | 11 | normal | Badges, tiny labels |

### Which style for which element

| UI element | Style |
|---|---|
| Main screen title | `heading1` |
| Section title on the page | `heading2` |
| Subtitle / group header | `heading3` |
| Card or list item title | `heading4` |
| Body text, descriptions | `body` |
| Input text, compact UI | `bodyMedium` |
| Secondary text / note / hint | `bodySecondary` |
| Labels, metadata, secondary info | `caption` |
| Badges, chip text, tiny labels | `small` |

---

## AppDesign — `lib/helpers/app_design.dart`

Access: `AppDesign.{token}` (all static).

### Border radius — by element type

| Element | Token | Value |
|---|---|---|
| Badges, small chips, tags | `borderRadiusXXs` | 6 |
| Inputs, buttons, small cards | `borderRadiusXs` | 10 |
| Medium cards | `borderRadiusSm` | 20 |
| Large cards, modals, bottom sheets | `borderRadiusMd` | 32 |
| Pill, avatar, full-round elements | `borderRadiusLg` | 48 |
| Top/bottom corners only | `borderRadiusTop/BottomSm/Md/Lg` | — |

### Vertical gap — between elements

| Distance | Token | Value | When |
|---|---|---|---|
| Title ↔ subtitle, label ↔ value | `gapItemXs` | 4 | Tightly coupled elements |
| Image ↔ text, icon ↔ description | `gapItemSm` | 8 | Cohesive group |
| Distinct info groups in the same component | `gapItemMd` | 16 | Distinct info |
| Related sections on the page | `gapSectionXs` | 10 | Close sections |
| Separate sections on the page | `gapSectionSm` | 16 | Standard separation |
| Distinct sections | `gapSectionMd` | 20 | Different blocks |
| Widely separated sections | `gapSectionLg` | 24 | Large separation |

### Horizontal gap — between inline elements

| Distance | Token | Value | When |
|---|---|---|---|
| Icon ↔ label | `gapInlineXs` | 4 | Tightly coupled |
| Related inline elements | `gapInlineSm` | 8 | Close |
| Distinct inline elements | `gapInlineMd` | 16 | Wide spacing |

### Padding — by context

| Context | Token |
|---|---|
| Standard page padding (left/right 20) | `paddingPage` |
| Internal padding small card | `paddingSymmetricSm` (h:8, v:4) |
| Internal padding card / section | `paddingSymmetricMd` (h:16, v:8) |
| Internal padding wide element | `paddingSymmetricLg` (h:20, v:8) |
| Horizontal padding only | `paddingHorizontalSm/Md/Lg` |
| Uniform padding | `paddingXs`(4) `paddingSm`(8) `paddingMd`(16) `paddingLg`(20) `paddingXl`(24) |

---

## Icons — `phosphor_flutter`

The default icon style is **`regular`**. Use other styles only when explicitly requested.

```dart
import 'package:phosphor_flutter/phosphor_flutter.dart';

// With Icon wrapper:
Icon(PhosphorIconsRegular.fileText)
Icon(PhosphorIconsFill.heart)
Icon(PhosphorIconsBold.arrowLeft)

// As IconData directly (e.g. prefixIcon parameter):
PhosphorIconsRegular.fileText
```

Available classes: `PhosphorIconsRegular`, `PhosphorIconsBold`, `PhosphorIconsFill`, `PhosphorIconsDuotone`, `PhosphorIconsLight`, `PhosphorIconsThin`.

---

## Widget delivery checklist

- [ ] No hardcoded colours — all from `AppColors`
- [ ] No hardcoded `fontSize` — all from `AppTypography.of(context)`
- [ ] No hardcoded spacing — all from `AppDesign` gap/padding tokens
- [ ] No hardcoded `BorderRadius.circular(x)` — all from `AppDesign`
- [ ] Network images use `BaseImageContainer`
- [ ] Buttons use `BaseButton` / `BaseIconButton`
- [ ] Inputs use `BaseInput` / `BaseFormField`
