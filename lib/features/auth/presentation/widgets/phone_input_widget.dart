import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class PhoneInputWidget extends StatelessWidget {
  final TextEditingController countryCodeController;
  final TextEditingController phoneController;
  final List<String> countryCodes;

  const PhoneInputWidget({
    super.key,
    required this.countryCodeController,
    required this.phoneController,
    required this.countryCodes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: ValueListenableBuilder<TextEditingValue>(
            valueListenable: countryCodeController,
            builder: (context, value, child) {
              return TextFormField(
                controller: countryCodeController,
                style: AppTextStyles.bodyLargeBold,
                textAlign: TextAlign.center,
                readOnly: true,
                onTap: () => _showCountryCodePicker(context),
                decoration: _buildInputDecoration(
                  horizontalPadding: 0,
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    // weight: 25,
                    size: 20,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextFormField(
            controller: phoneController,
            style: AppTextStyles.bodyLarge,
            keyboardType: TextInputType.phone,
            decoration: _buildInputDecoration(hintText: 'Enter Mobile Number'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter phone number';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  void _showCountryCodePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Country Code',
                style: AppTextStyles.headline.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                itemCount: countryCodes.length,
                itemBuilder: (context, index) {
                  final code = countryCodes[index];
                  return ListTile(
                    title: Text(code, style: AppTextStyles.bodyLarge),
                    onTap: () {
                      countryCodeController.text = code;
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  InputDecoration _buildInputDecoration({
    String? hintText,
    double horizontalPadding = 16,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      suffixIcon: suffixIcon,
      hintText: hintText,
      hintStyle: AppTextStyles.hintText,
      filled: true,
      fillColor: AppColors.inputFill,
      contentPadding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.textFieldBorder,
          width: .5,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.textFieldBorder,
          width: .5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.textFieldBorder,
          width: .5,
        ),
      ),
      errorStyle: const TextStyle(color: AppColors.error),
    );
  }
}
