import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppNavigationBarIcon extends StatelessWidget {
  final int selectedIndex;
  final String logo;
  final int index;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final bool? isBadgeVisible;
  final String? badgeLabel;
  final String logoFill;

  const AppNavigationBarIcon({
    super.key,
    required this.selectedIndex,
    required this.index,
    required this.logo,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.isBadgeVisible,
    this.badgeLabel,
    required this.logoFill,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;
    final iconPath = isSelected ? logoFill : logo;

    final icon = SvgPicture.asset(
    iconPath,
      width: AppSizes.constSize24 ,
      height: AppSizes.constSize24 ,

    );

    final iconWithPadding = Padding(
      padding: const EdgeInsets.all(AppSizes.constSize6),
      child:
          (isBadgeVisible ?? false)
              ? Badge(
                isLabelVisible: badgeLabel != null && badgeLabel!.isNotEmpty,
                label: Text(badgeLabel ?? ''),
                child: icon,
              )
              : icon,
    );

    return iconWithPadding;
  }
}
