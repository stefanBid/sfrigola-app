import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_image_selector_bottom_sheet.dart';

/// Tappable image preview that opens a bottom sheet to pick a photo from the
/// gallery or take one with the camera.
///
/// The widget is stateless — the caller owns the image state:
/// - [localImage]: the [XFile] currently selected by the user (null = no image).
/// - [onImageSelected]: called with the new [XFile] on pick, or `null` when the user removes the image.
class BaseImagePicker extends StatelessWidget {
  const BaseImagePicker({
    super.key,
    this.localImage,
    this.height = 200,
    required this.onImageSelected,
  });

  final XFile? localImage;
  final ValueChanged<XFile?> onImageSelected;
  final double height;

  bool get _hasImage => localImage != null;

  Future<void> _pickImage(ImageSource source) async {
    final file = await ImagePicker().pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 1200,
    );
    onImageSelected(file);
  }

  void _showOptions(BuildContext context) {
    BaseImageSelectorBottomSheet.show(
      context,
      onImageSourceSelected: _pickImage,
      hasImage: _hasImage,
      onRemove: () => onImageSelected(null),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: AppDesign.borderRadiusMd,
        border: Border.all(color: AppColors.of(context).muted.withAlpha(80)),
      ),
      child: ClipRRect(
        borderRadius: AppDesign.borderRadiusMd,
        child: Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(color: AppColors.of(context).surface),
            child: InkWell(
              splashColor: AppColors.of(context).text.withAlpha(60),
              highlightColor: AppColors.of(context).text.withAlpha(30),
              onTap: () => _showOptions(context),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (localImage != null)
                    Image.file(File(localImage!.path), fit: BoxFit.cover)
                  else
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          PhosphorIconsRegular.imagesSquare,
                          size: AppDesign.iconSizeXxl,
                          color: AppColors.of(context).muted,
                        ),
                        const SizedBox(height: AppDesign.gapItemSm),
                        Text(
                          AppLocale.getLabels(context).imagePickerLabelAdd,
                          style: AppTypography.of(context).caption.copyWith(
                            color: AppColors.of(context).muted,
                          ),
                        ),
                      ],
                    ),
                  if (_hasImage)
                    Positioned(
                      bottom: AppDesign.gapItemSm,
                      right: AppDesign.gapItemSm,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(140),
                          borderRadius: AppDesign.borderRadiusXs,
                        ),
                        child: const Icon(
                          PhosphorIconsRegular.pencilSimple,
                          size: AppDesign.iconSizeMd,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
