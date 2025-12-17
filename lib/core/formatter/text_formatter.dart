import 'package:flutter/material.dart';

class TextFormatter {
  static String formatLocationText(
    BuildContext context, {
    String? street,
    String? houseNumber,
    String? city,
  }) {
    final hasStreet = (street?.trim() ?? '').isNotEmpty;
    final hasHouseNumber = (houseNumber?.trim() ?? '').isNotEmpty;
    final hasCity = (city?.trim() ?? '').isNotEmpty;

    String streetAndHouse = '';
    if (hasStreet && hasHouseNumber) {
      streetAndHouse = '${street!.trim()} ${houseNumber!.trim()}';
    } else if (hasStreet) {
      streetAndHouse = street!.trim();
    }

    final addressParts = [
      if (streetAndHouse.isNotEmpty) streetAndHouse,
      if (hasCity) city!.trim(),
    ];

    return addressParts.isNotEmpty
        ? addressParts.join(', ')
        : 'Please select a location';
  }
}
