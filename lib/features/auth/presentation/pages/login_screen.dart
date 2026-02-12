import 'package:flutter/material.dart';
import 'package:novindus_feed_app/core/constants/app_colors.dart';
import 'package:novindus_feed_app/core/constants/app_text_styles.dart';
import 'package:novindus_feed_app/core/utils/snack_bar_utils.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../widgets/phone_input_widget.dart';
import '../widgets/login_button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _countryCodeController = TextEditingController(text: '+91');
  final _phoneController = TextEditingController(text: '8129466718');

  @override
  void dispose() {
    _countryCodeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),

                    Text(
                      'Enter Your\nMobile Number',
                      style: AppTextStyles.headline,
                    ),
                    const SizedBox(height: 16),

                    Text(
                      'Enter your 10-digit mobile number to verify your account, and enjoy seamless access to all our features.',
                      style: AppTextStyles.secondaryText.copyWith(height: 1.5),
                    ),
                    const SizedBox(height: 40),

                    PhoneInputWidget(
                      countryCodeController: _countryCodeController,
                      phoneController: _phoneController,
                      countryCodes: authProvider.countryCodes,
                    ),
                    const Spacer(),

                    LoginButtonWidget(
                      isLoading: authProvider.status == AuthStatus.loading,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          final success = await authProvider.login(
                            countryCode: _countryCodeController.text,
                            phone: _phoneController.text,
                          );
                          if (success && context.mounted) {
                            Navigator.pushReplacementNamed(context, '/home');
                            SnackbarUtils.showSuccess('Login Successful');
                            authProvider.reset();
                          } else if (context.mounted &&
                              authProvider.errorMessage != null) {
                            SnackbarUtils.showError(authProvider.errorMessage!);
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
