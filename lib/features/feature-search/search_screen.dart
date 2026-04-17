import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_logger.dart';
import 'package:sfrigola/core/helpers/app_router.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

// Project Layouts
import 'package:sfrigola/core/layouts/app_bars/classic_app_bar.dart';
import 'package:sfrigola/core/layouts/body/standard_page_layout.dart';

// Project Widgets
import 'package:sfrigola/features/feature-search/widgets/general_search_box.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardPageLayout(
      appBar: ClassicAppBar(
        leading: const Icon(Icons.search),
        title: AppLocale.getLabels(context).homeTitle,
        bottomContent: GeneralSearchBox(
          onBlurEmpty: () => AppRouter.goBack(context),
          onChanged: (_) => AppLogger.debug('searching...'),
        ),
      ),
      body: Center(
        child: Text(
          AppLocale.getLabels(context).homeTitle,
          style: AppTypography.of(context).heading1,
        ),
      ),
    );
  }
}
