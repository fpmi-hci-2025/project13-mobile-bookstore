import 'package:bookstore/core/models/location_model.dart';
import 'package:bookstore/core/services/location_service.dart';
import 'package:bookstore/features/location/controller/select_street_controller.dart';
import 'package:bookstore/features/location/presentation/pages/select_location/presentation/components/select_street_list.dart';
import 'package:bookstore/features/location/presentation/pages/select_location/presentation/widget/select_street_content.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/theme/app_colors.dart';
import 'package:bookstore/shared/widgets/app_header_widget.dart';
import 'package:flutter/material.dart';

class SelectLocationPage extends StatefulWidget {
  const SelectLocationPage({super.key});

  @override
  State<SelectLocationPage> createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  late final SelectStreetController _controller;
  final LocationService _locationService = LocationService();
  List<LocationModel> _allLocations = [];

  @override
  void initState() {
    super.initState();
    _allLocations = LocationService.bookstoreLocations;
    
    _controller = SelectStreetController(
      onTextChanged: _onSearchChanged,
      onUpdate: () => setState(() {}),
    );
    
    // Show all locations initially
    _controller.setSuggestions(_allLocations);
  }

  void _onSearchChanged(String text) {
    if (text.isEmpty) {
      _controller.setSuggestions(_allLocations);
      return;
    }

    final filtered = _allLocations.where((e) =>
        e.street.toLowerCase().contains(text.toLowerCase()) ||
        e.city.toLowerCase().contains(text.toLowerCase()) ||
        e.region.toLowerCase().contains(text.toLowerCase()) ||
        e.zipCode.toLowerCase().contains(text.toLowerCase())
    ).toList();

    _controller.setSuggestions(filtered);
  }

  Future<void> _onLocationSelected(LocationModel location) async {
    await _locationService.saveLocation(location);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location set to ${location.street}, ${location.city}'),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context, location);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => _controller.unfocusAll(context),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Padding(
          padding: EdgeInsets.only(top: AppSizes.size47H),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHeaderWidget(theme: theme, text: 'Select location'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.sizeW16),
                child: SelectStreetContent(
                  isActiveTextField: _controller.isActiveTextField,
                  focusNodeTextField: _controller.focusNodeTextField,
                  controller: _controller.controller,
                  showCancel: _controller.controller.text.isNotEmpty,
                  showNyCurrentLocation: false,
                  onPressedTextButton: _controller.onCurrentLocationPressed,
                  onPressedTextButtonCancel: () {
                    _controller.controller.clear();
                    _controller.setSuggestions(_allLocations);
                  },
                ),
              ),
              SizedBox(height: AppSizes.sizeH16),
              
              // Results header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.sizeW16),
                child: Text(
                  'Available Bookstore Locations (${_controller.suggestions.length})',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: AppSizes.sizeH8),
              
              Expanded(
                child: _controller.suggestions.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_off,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No locations found',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Try a different search term',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: _controller.suggestions.length,
                        itemBuilder: (context, index) {
                          final item = _controller.suggestions[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.sizeW16,
                            ),
                            child: SelectStreetList(
                              suggestion: item,
                              onTap: () => _onLocationSelected(item),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
