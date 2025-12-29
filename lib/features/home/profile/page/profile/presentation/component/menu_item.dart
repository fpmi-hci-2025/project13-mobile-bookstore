import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.title,
    required this.theme,
    required this.onTap,
    this.icon,
    this.svgIcon,
    this.textColor,
    this.iconColor,
  });

  final String title;
  final ThemeData theme;
  final VoidCallback onTap;
  final IconData? icon;
  final String? svgIcon;
  final Color? textColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? AppColors.primary;
    final effectiveTextColor = textColor ?? theme.colorScheme.onPrimary;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.borderSize12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.sizeW16, vertical: AppSizes.sizeH8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.10),
              offset: const Offset(0, 2),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: AppSizes.constSize40,
              height: AppSizes.constSize40,
              decoration: BoxDecoration(
                color: effectiveIconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: icon != null
                    ? Icon(icon, color: effectiveIconColor, size: AppSizes.constSize20)
                    : svgIcon != null
                        ? SvgPicture.asset(
                            svgIcon!,
                            width: AppSizes.constSize20,
                            height: AppSizes.constSize20,
                            colorFilter: ColorFilter.mode(
                              effectiveIconColor,
                              BlendMode.srcIn,
                            ),
                          )
                        : const SizedBox(),
              ),
            ),
            SizedBox(width: AppSizes.sizeW16),
            // Title
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: effectiveTextColor,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: theme.colorScheme.secondary),
          ],
        ),
      ),
    );
  }
}
