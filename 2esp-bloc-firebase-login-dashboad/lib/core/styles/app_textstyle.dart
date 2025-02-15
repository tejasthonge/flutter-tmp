import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './index.dart';

class AppTextstyle {
  static TextStyle textStyle24w600 = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.color000000,
  );
  static TextStyle textStyle36w600 = GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    color: AppColors.color000000,
  );
  static TextStyle textStyle40w600 = GoogleFonts.b612(
    fontSize: 40,
    fontWeight: FontWeight.w600,
    foreground: Paint()
      ..style = PaintingStyle.stroke
      ..color = AppColors.colorFFFFF7
      ..strokeWidth = 2,
  );

  static TextStyle textStyle48w600 = GoogleFonts.inter(
    fontSize: 48,
    fontWeight: FontWeight.w600,
    color: AppColors.color000000,
  );
  static TextStyle textStyle20w500 = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.color000000,
  );
  static TextStyle textStyle20w600 = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.color000000,
  );

  static TextStyle textStyle18w600 = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.color000000,
  );
  static TextStyle textStyle15w600 = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.color000000,
  );
  static TextStyle textStyle15w400 = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.color000000,
  );
  static TextStyle textStyle16w400 = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.color000000,
  );
  static TextStyle textStyle16w500 = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.color000000,
  );
  static TextStyle textStyle14w400 = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.color000000,
  );
  static TextStyle textStyle12w400 = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.color000000,
  );
  static TextStyle textStyle10w400 = GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.color000000,
  );
}
