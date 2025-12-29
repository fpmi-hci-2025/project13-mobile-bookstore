import 'package:bookstore/features/location/presentation/pages/select_location/presentation/components/location_icon.dart';
import 'package:bookstore/shared/components/app_text_field.dart';
import 'package:bookstore/shared/constants/app_constants.dart' show AppConstants;
import 'package:bookstore/shared/constants/app_icons.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectStreetContent extends StatelessWidget {
  final VoidCallback onPressedTextButton;
  final bool isActiveTextField;
  final FocusNode focusNodeTextField;
  final TextEditingController controller;
  final bool showNyCurrentLocation;
  final Function() onPressedTextButtonCancel;
  final bool showCancel;

  const SelectStreetContent({
    super.key,
    required this.onPressedTextButton,
    required this.isActiveTextField,
    required this.focusNodeTextField,
    required this.controller,
    required this.showNyCurrentLocation,
    required this.onPressedTextButtonCancel,
    required this.showCancel,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AppTextField(
                placeholderText: 'Enter address',
                textFieldWidth: double.infinity,
                textFieldHeight: AppSizes.constSize44,
                borderRadius: AppSizes.borderSize12,
                showCursor: true,
                isActive: isActiveTextField,
                focusNode: focusNodeTextField,
                textAlign: TextAlign.left,
                controller: controller,
                textLimit: AppConstants.textLimit50,
                isNumericInput: false,
                inlineIcon: SvgPicture.asset(
                  AppIcons.loupe,
                  width: AppSizes.sizeW18,
                  height: AppSizes.sizeW18,
                  color: theme.colorScheme.tertiary,
                ),
                suffixWidget: showCancel
                    ? GestureDetector(
                        onTap: onPressedTextButtonCancel,
                        child: Container(
                          width: AppSizes.sizeW18,
                          height: AppSizes.sizeW18,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.colorScheme.secondary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(AppSizes.constSize3),
                            child: SvgPicture.asset(
                              AppIcons.close,
                              color: theme.colorScheme.surface,
                            ),
                          ),
                        ),
                      )
                    : null,
                horizantalPadding: AppSizes.sizeW12,
                verticalPadding: AppSizes.sizeH8,
              ),
            ),
          ],
        ),
        if (showNyCurrentLocation == true) ...[
          Column(
            children: [
              SizedBox(height: AppSizes.sizeH16),
              GestureDetector(
                onTap: onPressedTextButton,
                child: Row(
                  children: [
                    SizedBox(width: AppSizes.sizeW12),
                    LocationIcon(
                      locationImage: AppIcons.location,
                      padding: AppSizes.constSize9,
                    ),
                    SizedBox(width: AppSizes.sizeW8),
                    Text(
                      'Use my current location',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        SizedBox(height: AppSizes.sizeH8),
      ],
    );
  }
}
