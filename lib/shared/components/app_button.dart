import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final double buttonWidth;
  final double buttonHeight;
  final bool isEnabled;
  final double? borderRadius;
  final String? image;
  final TextStyle? textStyle;
  final double? horizontalPadding;
  final double? imageWidth;
  final double? imageHeight;
  final double? imagePadding;
  final Color? imageColor;
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonColor,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.isEnabled,
    this.borderRadius,
    this.image,
    this.textStyle,
    this.horizontalPadding,
    this.imageHeight = 20,
    this.imageWidth = 20,
    this.imagePadding = 8,
    this.imageColor
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (isEnabled) {
          onPressed();
        }
      },
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          color: isEnabled
              ? (buttonColor ?? theme.colorScheme.primary)
              : theme.colorScheme.primary.withOpacity(0.7),
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppSizes.borderSize8,
          
          ),
          border: Border.all(color: theme.colorScheme.primary, width: 1.5)
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: horizontalPadding ?? AppSizes.sizeW16,
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (image != null) ...[
                  SvgPicture.asset(
                    image!,
                    width: imageWidth,
                    height: imageHeight,
                    colorFilter: ColorFilter.mode(
                      imageColor ?? theme.colorScheme.surface,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: imagePadding),
                ],
                Text(
                  text,
                  style:
                      textStyle ??
                      theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.surface,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
