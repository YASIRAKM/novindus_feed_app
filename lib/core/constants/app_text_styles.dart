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
  static TextStyle secondaryText = GoogleFonts.poppins(
    color: AppColors.textSecondary,
    fontSize: 14,
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
}
