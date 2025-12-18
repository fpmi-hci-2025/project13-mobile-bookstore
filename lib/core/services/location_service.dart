import 'dart:convert';
import 'package:bookstore/core/models/location_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationService {
  static const String _locationKey = 'selected_location';

  Future<void> saveLocation(LocationModel location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_locationKey, jsonEncode(location.toJson()));
  }

  Future<LocationModel?> getLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_locationKey);
    if (jsonString == null) return null;
    
    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return LocationModel.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  Future<void> clearLocation() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_locationKey);
  }

  // Predefined bookstore locations
  static List<LocationModel> get bookstoreLocations => [
    LocationModel(
      street: 'Baker Street',
      city: 'London',
      country: 'United Kingdom',
      houseNumber: '221B',
      latitude: 51.5237,
      longitude: -0.1585,
      region: 'Westminster',
      apartment: '',
      floor: '',
      zipCode: 'NW1 6XE',
    ),
    LocationModel(
      street: 'Oxford Street',
      city: 'London',
      country: 'United Kingdom',
      houseNumber: '100',
      latitude: 51.5154,
      longitude: -0.1410,
      region: 'Westminster',
      apartment: '',
      floor: '',
      zipCode: 'W1D 1LL',
    ),
    LocationModel(
      street: 'Charing Cross Road',
      city: 'London',
      country: 'United Kingdom',
      houseNumber: '84',
      latitude: 51.5131,
      longitude: -0.1279,
      region: 'Camden',
      apartment: '',
      floor: '',
      zipCode: 'WC2H 0BB',
    ),
    LocationModel(
      street: 'Piccadilly',
      city: 'London',
      country: 'United Kingdom',
      houseNumber: '203',
      latitude: 51.5074,
      longitude: -0.1406,
      region: 'Westminster',
      apartment: '',
      floor: '',
      zipCode: 'W1J 9HD',
    ),
    LocationModel(
      street: 'Brick Lane',
      city: 'London',
      country: 'United Kingdom',
      houseNumber: '55',
      latitude: 51.5219,
      longitude: -0.0718,
      region: 'Tower Hamlets',
      apartment: '',
      floor: '',
      zipCode: 'E1 6QL',
    ),
    LocationModel(
      street: 'King\'s Road',
      city: 'London',
      country: 'United Kingdom',
      houseNumber: '152',
      latitude: 51.4875,
      longitude: -0.1687,
      region: 'Chelsea',
      apartment: '',
      floor: '',
      zipCode: 'SW3 4UT',
    ),
    LocationModel(
      street: 'Camden High Street',
      city: 'London',
      country: 'United Kingdom',
      houseNumber: '78',
      latitude: 51.5392,
      longitude: -0.1426,
      region: 'Camden',
      apartment: '',
      floor: '',
      zipCode: 'NW1 0LT',
    ),
    LocationModel(
      street: 'Notting Hill Gate',
      city: 'London',
      country: 'United Kingdom',
      houseNumber: '42',
      latitude: 51.5093,
      longitude: -0.1965,
      region: 'Kensington',
      apartment: '',
      floor: '',
      zipCode: 'W11 3HT',
    ),
  ];
}

