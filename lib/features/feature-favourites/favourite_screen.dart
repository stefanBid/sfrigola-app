import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// project Helpers
import 'package:sfrigola/core/helpers/app_locale.dart';

// Project Layouts
import 'package:sfrigola/core/layouts/app_bars/classic_app_bar.dart';
import 'package:sfrigola/core/layouts/body/standard_page_layout.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardPageLayout(
      appBar: ClassicAppBar(
        leading: const Icon(PhosphorIconsBold.heart),
        title: AppLocale.getLabels(context).favouritesTitle,
      ),
      body: const Center(child: Text('Favourites')),
    );
  }
}
