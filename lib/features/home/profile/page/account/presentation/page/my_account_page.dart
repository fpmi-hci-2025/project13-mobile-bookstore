import 'package:bookstore/shared/components/app_button.dart';
import 'package:bookstore/shared/components/app_text_field.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/widgets/app_header_widget.dart';
import 'package:flutter/material.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}


class _MyAccountPageState extends State<MyAccountPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _nameController;

  // Исходные значения
  final String _initialEmail = 'user@example.com';
  final String _initialName = 'John Doe';

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController(text: _initialEmail);
    _nameController = TextEditingController(text: _initialName);

    // Добавляем слушателей для обновления состояния кнопки
    _emailController.addListener(_updateState);
    _nameController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {}); // обновляем UI, чтобы пересчитать isEnabled
  }

  bool get _isChanged {
    return _emailController.text != _initialEmail ||
        _nameController.text != _initialName;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: AppSizes.size47H),
          child: Column(
            children: [
              AppHeaderWidget(theme: theme, text: 'My account'),
              Padding(
                padding: EdgeInsets.only(
                  right: AppSizes.sizeW16,
                  left: AppSizes.sizeW16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80',
                        ),
                      ),
                    ),
                    SizedBox(height: AppSizes.sizeH16),
                    Text('Name', style: theme.textTheme.bodyMedium),
                    AppTextField(
                      textFieldWidth: double.infinity,
                      textFieldHeight: AppSizes.constSize46,
                      borderRadius: AppSizes.borderSize16,
                      horizantalPadding: AppSizes.sizeW12,
                      verticalPadding: 1,
                      textLimit: 40,
                      showCursor: true,
                      textAlign: TextAlign.start,
                      controller: _nameController,
                      isNumericInput: false,
                    ),
                    SizedBox(height: AppSizes.sizeH16),
                    Text('Email', style: theme.textTheme.bodyMedium),
                    AppTextField(
                      textFieldWidth: double.infinity,
                      textFieldHeight: AppSizes.constSize46,
                      borderRadius: AppSizes.borderSize16,
                      horizantalPadding: AppSizes.sizeW12,
                      verticalPadding: 1,
                      textLimit: 40,
                      showCursor: true,
                      textAlign: TextAlign.start,
                      controller: _emailController,
                      isNumericInput: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            bottom: AppSizes.sizeH34,
            right: AppSizes.sizeW16,
            left: AppSizes.sizeW16,
          ),
          child: AppButton(
            text: 'Save changes',
              borderRadius: AppSizes.borderSize24,
            onPressed: _isChanged
                ? () {
                    Navigator.pop(context);
                    print('Changes saved');
                  }
                : () {},
            buttonWidth: double.infinity,
            buttonHeight: AppSizes.constSize46,
            isEnabled: _isChanged, // кнопка активна только при изменении
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
