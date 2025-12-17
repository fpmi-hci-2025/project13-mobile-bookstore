import 'package:bookstore/core/config/app_routes.dart';
import 'package:bookstore/core/models/location_model.dart';
import 'package:bookstore/features/location/controller/select_street_controller.dart';
import 'package:bookstore/features/location/presentation/pages/select_location/presentation/components/select_street_list.dart';
import 'package:bookstore/features/location/presentation/pages/select_location/presentation/widget/select_street_content.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/widgets/app_header_widget.dart';
import 'package:flutter/material.dart';

class SelectLocationPage extends StatefulWidget {
  const SelectLocationPage({super.key});

  @override
  State<SelectLocationPage> createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  late final SelectStreetController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SelectStreetController(
      onTextChanged: _onSearchChanged,
      onUpdate: () => setState(() {}),
    );
  }

  void _onSearchChanged(String text) {
    final data = [
      LocationModel(
        street: 'Baker Street',
        city: 'London',
        country: 'UK',
        houseNumber: '221B',
        latitude: 51.5237,
        longitude: -0.1585,
        region: 'London',
        apartment: '',
        floor: '',
        zipCode: 'NW1',
      ),
      LocationModel(
        street: 'Oxford Street',
        city: 'London',
        country: 'UK',
        houseNumber: '',
        latitude: 51.5154,
        longitude: -0.1410,
        region: 'London',
        apartment: '',
        floor: '',
        zipCode: '',
      ),
    ];

    // Фильтруем по вводу
    final filtered = data
        .where((e) =>
            e.street.toLowerCase().contains(text.toLowerCase()) ||
            e.city.toLowerCase().contains(text.toLowerCase()))
        .toList();

    _controller.setSuggestions(filtered);
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
                  showCancel: _controller.controller.text.isNotEmpty &&
                      !_controller.isActiveTextField,
                  showNyCurrentLocation:
                      _controller.suggestions.isEmpty &&
                          _controller.controller.text.isEmpty,
                  onPressedTextButton: _controller.onCurrentLocationPressed,
                  onPressedTextButtonCancel: () {
                    _controller.controller.clear();
                  },
                ),
              ),
              SizedBox(height: AppSizes.sizeH8),
              Expanded(
                child: ListView.builder(
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
                        onTap: () {
                           Navigator.pushReplacementNamed(context, AppRoutes.navigation);
                        },
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
