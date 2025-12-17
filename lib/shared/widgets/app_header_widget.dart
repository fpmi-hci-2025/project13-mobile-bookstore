import 'package:bookstore/shared/constants/app_icons.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AppHeaderWidget extends StatelessWidget {
  const AppHeaderWidget({
    super.key,
    required this.theme,
    required this.text,
    this.notes = '',
    this.showNotes = false,
    this.showButton = false,
    this.buttonWidget,
    this.isActiveAccount = false,
    this.textStyle,
    this.backButtonImage,
    this.buttonColor,
    this.backFunction
  });

  final ThemeData theme;
  final String text;
  final bool showNotes;
  final String notes;
  final bool showButton;
  final Widget? buttonWidget;
  final bool? isActiveAccount;
  final Function()? backFunction;
  final TextStyle? textStyle;
  final String? backButtonImage;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.sizeH56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap:backFunction ??  () {
                
                  Navigator.pop(context);
     
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.sizeW16),
                child: SvgPicture.asset(
                  backButtonImage ?? AppIcons.arrowBack,
                  color: buttonColor ?? theme.colorScheme.onSurface,
                ),
              ),
            ),
          ),

          Center(
            child: Text(
              text,
              style: textStyle ?? theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: AppSizes.sizeW16),
              child: showNotes
                  ? Text(
                      notes,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.tertiary,
                      ),
                    )
                  : (showButton
                        ? buttonWidget ?? const SizedBox()
                        : SizedBox(width: AppSizes.sizeW30)),
            ),
          ),
        ],
      ),
    );
  }
}
