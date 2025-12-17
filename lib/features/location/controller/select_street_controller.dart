import 'dart:async';
import 'package:bookstore/core/models/location_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class SelectStreetController {
  final FocusNode focusNodeTextField = FocusNode();
  final TextEditingController controller = TextEditingController();

  bool isActiveTextField = false;
  bool isUsingCurrentLocation = false;

  List<LocationModel> suggestions = [];

  Timer? _debounce;

  final Function(String) onTextChanged;
  final VoidCallback? onUpdate;

  SelectStreetController({
    required this.onTextChanged,
    required this.onUpdate,
  }) {
    focusNodeTextField.addListener(() {
      isActiveTextField = focusNodeTextField.hasFocus;
      onUpdate?.call();
    });

    controller.addListener(() {
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 150), () {
        final text = controller.text;

        if (text.isEmpty) {
          suggestions.clear();
          onUpdate?.call();
          return;
        }

        onTextChanged(text);
      });
    });
  }

  void onCurrentLocationPressed() {
    isUsingCurrentLocation = true;
    onUpdate?.call();
  }

  void setSuggestions(List<LocationModel> newList) {
    suggestions = newList;
    onUpdate?.call();
  }

  void unfocusAll(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void dispose() {
    focusNodeTextField.dispose();
    controller.dispose();
    _debounce?.cancel();
  }
}
