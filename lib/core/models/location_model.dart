class LocationModel {
  final String street;
  final String city;
  final String country;
  final String houseNumber;
  final double latitude;
  final double longitude;
  final String region;
  String apartment;
  String floor;
  String zipCode;
  LocationModel({
    required this.street,
    required this.city,
    required this.country,
    required this.houseNumber,
    required this.latitude,
    required this.longitude,
    required this.region,
    required this.apartment,
    required this.floor,
    required this.zipCode,
  });

  Map<String, dynamic> toJson() {
    final data = {
      'street': street,
      'city': city,
      'country': country,
      'houseNumber': houseNumber,
      'latitude': latitude,
      'longitude': longitude,
      'apartment': apartment,
      'floor': floor,
      'zipCode': zipCode,
    };
    if (region.trim().isNotEmpty && region != null) {
      data['region'] = region;
    }
    return data;
  }

  Map<String, dynamic> toSendJson() {
    final data = {
      'country': country,
      'city': city,
      'street': street,
      'houseNumber': houseNumber,
      'latitude': latitude,
      'longitude': longitude,
    };
    if (region.trim().isNotEmpty && region != null) {
      data['region'] = region;
    }
    return data;
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      street: json['street'] ?? ' ',
      city: json['city'] ?? ' ',
      country: json['country'] ?? ' ',
      houseNumber: json['houseNumber'] ?? ' ',
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
      region: json['region'] ?? ' ',
      apartment: json['apartment'] ?? '',
      floor: json['floor'] ?? '',
      zipCode: json['zipCode'] ?? '',
    );
  }
}
