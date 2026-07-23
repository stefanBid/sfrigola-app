import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_flutter/lucide_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_bottom_sheet.dart';

class BaseImageSelectorBottomSheet {
  const BaseImageSelectorBottomSheet._();

  static void show(
    BuildContext context, {
    required void Function(ImageSource source) onImageSourceSelected,
    bool hasImage = false,
    void Function()? onRemove,
  }) {
    final l = AppLocale.getLabels(context);
    BaseBottomSheet.show(
      context,
      title: l.imagePickerSheetTitle,
      child: Builder(
        builder: (sheetContext) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                LucideIcons.image,
                size: AppDesign.iconSizeLg,
                color: AppColors.of(context).text,
              ),
              title: Text(
                l.imagePickerGallery,
                style: AppTypography.of(context).body,
              ),
              onTap: () {
                BaseBottomSheet.hide(sheetContext);
                onImageSourceSelected(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(
                LucideIcons.camera,
                size: AppDesign.iconSizeLg,
                color: AppColors.of(context).text,
              ),
              title: Text(
                l.imagePickerCamera,
                style: AppTypography.of(context).body,
              ),
              onTap: () {
                BaseBottomSheet.hide(sheetContext);
                onImageSourceSelected(ImageSource.camera);
              },
            ),
            if (hasImage && onRemove != null)
              ListTile(
                leading: const Icon(
                  LucideIcons.trash2,
                  size: AppDesign.iconSizeLg,
                  color: AppColors.error,
                ),
                title: Text(
                  l.imagePickerRemove,
                  style: AppTypography.of(
                    context,
                  ).body.copyWith(color: AppColors.error),
                ),
                onTap: () {
                  BaseBottomSheet.hide(sheetContext);
                  onRemove();
                },
              ),
          ],
        ),
      ),
    );
  }
}

