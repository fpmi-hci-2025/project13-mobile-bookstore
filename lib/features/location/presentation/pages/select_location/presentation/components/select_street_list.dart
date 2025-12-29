import 'package:bookstore/core/formatter/text_formatter.dart';
import 'package:bookstore/core/models/location_model.dart';
import 'package:bookstore/shared/constants/app_icons.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectStreetList extends StatelessWidget {
  final LocationModel suggestion;
  final Function() onTap;

  const SelectStreetList({
    super.key,
    required this.suggestion,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: AppSizes.sizeW375,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.sizeW12,
              vertical: AppSizes.sizeH8,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.onLocationFilled,
                      width: AppSizes.sizeW16,
                      height: AppSizes.sizeH18,
                      color: AppColors.secondary,
                    ),
                    SizedBox(width: AppSizes.sizeW8),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 310),
                      child: Text(
                        TextFormatter.formatLocationText(
                          context,
                          city: suggestion.city,
                          street: suggestion.street,
                          houseNumber: suggestion.houseNumber.toString(),
                        ),
                        style: textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.sizeH16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
