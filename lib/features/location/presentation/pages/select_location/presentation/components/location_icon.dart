import 'package:bookstore/shared/constants/app_icons.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LocationIcon extends StatelessWidget {
  final double? width;
  final double? height;
  final String? locationImage;
  final double? padding;

  const LocationIcon({
    super.key,
    this.height,
    this.width,
    this.locationImage,
    this.padding,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? AppSizes.constSize38,
      height: height ?? AppSizes.constSize38,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary.withOpacity(0.2),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding ?? AppSizes.constSize7),
        child: SvgPicture.asset(
          locationImage ?? AppIcons.onLocationFilled,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
