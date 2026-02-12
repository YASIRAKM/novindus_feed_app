import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle headline = GoogleFonts.poppins(
    color: AppColors.textPrimary,
    fontSize: 28,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );
  static TextStyle bodyText = GoogleFonts.poppins(
    color: AppColors.textPrimary,
    fontSize: 14,
  );

  static TextStyle appBarTitle = GoogleFonts.poppins(
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w400,
  );
  static TextStyle secondaryText = GoogleFonts.poppins(
    color: AppColors.textSecondary,
    fontSize: 14,
  );
  static TextStyle sectionTitle = GoogleFonts.poppins(
    color: AppColors.textPrimary,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  static TextStyle hintText = GoogleFonts.poppins(color: Colors.white30);
  static TextStyle bodyLarge = GoogleFonts.poppins(
    color: AppColors.textPrimary,
    fontSize: 16,
  );
  static TextStyle bodyLargeBold = GoogleFonts.poppins(
    color: AppColors.textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static TextStyle primaryButton = GoogleFonts.poppins(
    color: AppColors.textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static TextStyle buttonText = GoogleFonts.poppins(
    color: AppColors.redColor,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
}
