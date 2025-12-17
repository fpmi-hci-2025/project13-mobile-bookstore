import 'package:bookstore/core/config/app_routes.dart';
import 'package:bookstore/core/models/location_model.dart';
import 'package:bookstore/core/services/location_service.dart';
import 'package:bookstore/shared/components/app_button.dart';
import 'package:bookstore/shared/constants/app_icons.dart';
import 'package:bookstore/shared/constants/app_images.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/theme/app_colors.dart';
import 'package:bookstore/shared/widgets/app_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyLocationPage extends StatefulWidget {
  const MyLocationPage({super.key});

  @override
  State<MyLocationPage> createState() => _MyLocationPageState();
}

class _MyLocationPageState extends State<MyLocationPage> {
  final LocationService _locationService = LocationService();
  LocationModel? _selectedLocation;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  Future<void> _loadLocation() async {
    final location = await _locationService.getLocation();
    setState(() {
      _selectedLocation = location;
      _isLoading = false;
    });
  }

  Future<void> _changeLocation() async {
    final result = await Navigator.pushNamed(context, AppRoutes.selectLocation);
    if (result is LocationModel) {
      setState(() {
        _selectedLocation = result;
      });
    } else {
      // Reload in case it was updated
      _loadLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.only(top: AppSizes.size47H),
        child: Column(
          children: [
            AppHeaderWidget(theme: theme, text: 'My location'),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          // Map placeholder
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.sizeW16,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppSizes.borderSize16),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    AppImages.map,
                                    width: double.infinity,
                                    height: AppSizes.constSize240,
                                    fit: BoxFit.cover,
                                  ),
                                  if (_selectedLocation != null)
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.1),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.location_on,
                                            color: AppColors.primary,
                                            size: 48,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: AppSizes.sizeH24),
                          
                          // Location details card
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: AppSizes.sizeW16),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(AppSizes.borderSize16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.10),
                                  offset: const Offset(0, 4),
                                  blurRadius: 24,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(AppSizes.sizeW16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Delivery Address',
                                        style: theme.textTheme.headlineLarge?.copyWith(
                                          fontSize: 20,
                                        ),
                                      ),
                                      const Spacer(),
                                      if (_selectedLocation != null)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.green.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
                                                size: 14,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Selected',
                                                style: theme.textTheme.bodySmall?.copyWith(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: AppSizes.sizeH24),
                                  
                                  if (_selectedLocation == null)
                                    // No location selected
                                    Container(
                                      padding: const EdgeInsets.all(24),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.location_off,
                                            size: 48,
                                            color: Colors.grey[400],
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            'No location selected',
                                            style: theme.textTheme.bodyLarge?.copyWith(
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Choose a pickup location for your orders',
                                            style: theme.textTheme.bodySmall?.copyWith(
                                              color: Colors.grey,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    )
                                  else
                                    // Location details
                                    Column(
                                      children: [
                                        _buildLocationRow(
                                          theme,
                                          AppIcons.location,
                                          'Street',
                                          '${_selectedLocation!.houseNumber} ${_selectedLocation!.street}',
                                        ),
                                        SizedBox(height: AppSizes.sizeH16),
                                        _buildDivider(theme),
                                        SizedBox(height: AppSizes.sizeH16),
                                        _buildLocationRow(
                                          theme,
                                          Icons.location_city,
                                          'City',
                                          _selectedLocation!.city,
                                        ),
                                        SizedBox(height: AppSizes.sizeH16),
                                        _buildDivider(theme),
                                        SizedBox(height: AppSizes.sizeH16),
                                        _buildLocationRow(
                                          theme,
                                          Icons.map,
                                          'Region',
                                          _selectedLocation!.region,
                                        ),
                                        SizedBox(height: AppSizes.sizeH16),
                                        _buildDivider(theme),
                                        SizedBox(height: AppSizes.sizeH16),
                                        _buildLocationRow(
                                          theme,
                                          Icons.markunread_mailbox,
                                          'Zip Code',
                                          _selectedLocation!.zipCode,
                                        ),
                                      ],
                                    ),
                                  
                                  SizedBox(height: AppSizes.sizeH24),
                                  
                                  AppButton(
                                    text: _selectedLocation == null 
                                        ? 'Select location' 
                                        : 'Change location',
                                    onPressed: _changeLocation,
                                    borderRadius: AppSizes.borderSize24,
                                    buttonWidth: double.infinity,
                                    buttonHeight: AppSizes.constSize46,
                                    isEnabled: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: AppSizes.sizeH24),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationRow(ThemeData theme, dynamic icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: AppSizes.constSize40,
          height: AppSizes.constSize40,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: icon is String
                ? SvgPicture.asset(
                    icon,
                    width: AppSizes.constSize20,
                    height: AppSizes.constSize20,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  )
                : Icon(
                    icon as IconData,
                    size: AppSizes.constSize20,
                    color: AppColors.primary,
                  ),
          ),
        ),
        SizedBox(width: AppSizes.sizeW16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value.isNotEmpty ? value : 'Not specified',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(ThemeData theme) {
    return Container(
      width: double.infinity,
      height: 1,
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppSizes.borderSize4),
      ),
    );
  }
}
