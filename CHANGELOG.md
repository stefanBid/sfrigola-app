## 2.0.0 - 2026-04-02
### Added
- Completely redesigned UI with a coherent and opinionated design system
- New Base components: BaseBadge, BaseScaffoldMessenger, BaseInput, BaseValueCard, BaseIconButton, GcGridView
- New ready-to-use screen templates: Home Page, Form Page, Profile Page and Detail Page
- Native AI development support via GitHub Copilot Agent: contextual instruction files, automated workflows (init-project, bump-version, check-dependencies, update-docs) and design system integrated into the model context

### Changed
- Project structure fully reorganised: leaner layout, consistent naming conventions for files and directories, clear separation between layouts, screens, widgets, helpers and services
- Design system centralised in AppColors, AppTypography and AppDesign with tokens for colours, typography, spacing and border radius
- Type-safe routing via AppRouter on top of go\_router: no more direct context.go() calls
- Migrated to cached\_network\_image for network image handling
- Removed flutter\_secure\_storage
- General update of all dependencies
