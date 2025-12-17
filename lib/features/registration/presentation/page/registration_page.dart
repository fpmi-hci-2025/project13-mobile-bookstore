import 'package:bookstore/features/registration/presentation/widget/registration_content_widget.dart';
import 'package:bookstore/features/registration/presentation/widget/registration_footer_widget.dart';
import 'package:bookstore/shared/components/app_title_component.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/theme/app_colors.dart';
import 'package:bookstore/shared/widgets/app_header_widget.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();

    _firstNameController.addListener(() {
      setState(() {});
    });
    _lastNameController = TextEditingController();

    _lastNameController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsetsGeometry.only(top: AppSizes.size47H),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHeaderWidget(
                theme: theme,
                text: '',
                showButton: false,
                backFunction: () {},
                buttonColor: AppColors.background,
              ),
              AppTitleComponent(
                theme: theme,
                header: 'Create your account',
                description: 'Enter your first and last name',
              ),

              RegistrationContentWidget(theme: theme, firstNameController: _firstNameController, lastNameController: _lastNameController),
            ],
          ),
        ),
        bottomNavigationBar: RegistrationFooterWidget(firstNameController: _firstNameController, lastNameController: _lastNameController),
      ),
    );
  }
}
