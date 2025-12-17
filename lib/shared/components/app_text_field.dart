import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  final String? placeholderText;

  final TextStyle? inputTextstyle;
  final Color? placeholderColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? activeBorderColor;
  final Color? cursorColor;
  final Color? backgroundColor;

  final double textFieldWidth;
  final double textFieldHeight;
  final double borderRadius;
  final double? borderWidth;
  final double horizantalPadding;
  final double verticalPadding;
  final double? cursorHeight;
  final double? cursorWidth;
  final double? iconPaddingRight;
  final int textLimit;

  final bool showCursor;
  final bool? isActive;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final TextAlign textAlign;
  final bool isNumericInput;

  final bool showSuffixIcon;
  final VoidCallback? onSuffixIconTap;
  final String? suffixIconImage;
  final Function(String)? onChanged;
  final Widget? inlineIcon;
  final bool? autoFocus;

  final int? maxLines;
  final Widget? suffixWidget;
  final bool showCharacterCounter;
  final int? minLines;
  final bool enabled; // new
  final bool? obscureText;

  const AppTextField({
    super.key,
    this.placeholderText,
    this.inputTextstyle,
    this.placeholderColor,
    this.textColor,
    this.borderColor,
    this.activeBorderColor,
    this.cursorColor,
    this.backgroundColor,
    required this.textFieldWidth,
    required this.textFieldHeight,
    required this.borderRadius,
    this.borderWidth,
    required this.horizantalPadding,
    required this.verticalPadding,
    this.cursorHeight,
    this.cursorWidth,
    this.iconPaddingRight,
    required this.textLimit,
    required this.showCursor,
    this.isActive,
    this.focusNode,
    required this.textAlign,
    required this.controller,
    required this.isNumericInput,
    this.showSuffixIcon = false,
    this.onSuffixIconTap,
    this.suffixIconImage,
    this.onChanged,
    this.inlineIcon,
    this.maxLines = 1,
    this.autoFocus = false,
    this.suffixWidget,
    this.showCharacterCounter = false,
    this.minLines = 1,
    this.enabled = true,
    this.obscureText = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late int _currentLength;
  int _lineCount = 1;
  @override
  void initState() {
    super.initState();
    _currentLength = widget.controller.text.length;
    widget.controller.addListener(() {
      setState(() {
        _currentLength = widget.controller.text.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: widget.textFieldWidth,
      height: widget.textFieldHeight,
      child: Stack(
        children: [
          Positioned.fill(
            child: TextField(
              enabled: widget.enabled,
obscureText: widget.obscureText!,
              controller: widget.controller,
              focusNode: widget.focusNode,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              autofocus: widget.autoFocus!,
              cursorHeight: widget.cursorHeight ?? 10,
              cursorWidth: widget.cursorWidth ?? 1,
              keyboardType: widget.isNumericInput
                  ? TextInputType.number
                  : TextInputType.text,
              textAlign: widget.textAlign,
              cursorColor: widget.cursorColor ?? theme.colorScheme.primary,
              onChanged: widget.onChanged,
              inputFormatters: [
                if (widget.isNumericInput)
                  FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(widget.textLimit),
              ],
              showCursor: widget.showCursor,
              style:
                  widget.inputTextstyle ??
                  theme.textTheme.bodyMedium?.copyWith(
                    color: widget.textColor ?? theme.colorScheme.onSurface,
                  ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  left: widget.inlineIcon != null
                      ? (widget.horizantalPadding) + 32
                      : (widget.horizantalPadding),
                  right: widget.showSuffixIcon
                      ? (widget.horizantalPadding) + 32
                      : (widget.horizantalPadding),
                  top: widget.verticalPadding,
                  bottom: widget.verticalPadding,
                ),
                hintText: widget.placeholderText,
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: widget.textColor ?? theme.colorScheme.tertiary,
                ),
                filled: true,
                fillColor: widget.backgroundColor ?? theme.colorScheme.surface,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? theme.colorScheme.surface,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                    width: 2,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? theme.colorScheme.surface,
                  ),
                ),
              ),
            ),
          ),
          if (widget.inlineIcon != null)
            Positioned(
              left: 12,
              top: 0,
              bottom: 0,
              child: Center(child: widget.inlineIcon!),
            ),
          if (widget.suffixWidget != null)
            Positioned(
              right: 12,
              top: 0,
              bottom: 0,
              child: Center(child: widget.suffixWidget!),
            ),
          if (widget.showCharacterCounter)
            Positioned(
              right: 12,
              bottom: 4,
              child: Text(
                '$_currentLength/${widget.textLimit}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.tertiary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
