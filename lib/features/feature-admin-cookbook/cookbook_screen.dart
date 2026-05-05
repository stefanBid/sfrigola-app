import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Widgets
import 'package:sfrigola/core/layouts/body/standard_page_layout.dart';
import 'package:sfrigola/core/layouts/app_bars/classic_app_bar.dart';

class CookbookScreen extends StatelessWidget {
  const CookbookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StandardPageLayout(
      appBar: ClassicAppBar(
        leading: Icon(PhosphorIconsBold.fileText),
        title: 'Manage App CookBook',
      ),
      body: Text('Cookbook'),
    );
  }
}
