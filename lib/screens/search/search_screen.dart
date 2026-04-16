import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_design.dart';
import 'package:sfrigola/helpers/app_locale.dart';
import 'package:sfrigola/helpers/app_typography.dart';
import 'package:sfrigola/helpers/app_colors.dart';
import 'package:sfrigola/helpers/app_router.dart';

// Project Layouts
import 'package:sfrigola/layouts/app_bars/classic_app_bar.dart';
import 'package:sfrigola/layouts/body/standard_page_layout.dart';

// Project Widgets
import 'package:sfrigola/screens/search/widgets/general_search_box.dart';

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
          onChanged: (_) => print('searching...'),
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
