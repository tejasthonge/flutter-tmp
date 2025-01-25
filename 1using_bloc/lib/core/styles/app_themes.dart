import 'package:flutter/material.dart';
import 'package:kequele/core/styles/app_colors.dart';
import 'package:kequele/core/styles/app_dimensions.dart';
import 'package:kequele/core/styles/app_textstyle.dart';


class AppThemes {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.white,
    dividerColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.white,
          minimumSize: const Size(120, 60),
          padding: EdgeInsets.symmetric(vertical: AppDimensions.mediumPadding, horizontal: AppDimensions.mediumPadding),
          elevation: 1,
          shape:  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(AppDimensions.largeRadius))),
          textStyle: AppTextstyle.textStyle14w400)
    ),
    
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 8,
      shadowColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Colors.black,
        size: 16.0,
      ),
      titleTextStyle: AppTextstyle.textStyle14w400,
    ),
    chipTheme: ChipThemeData(
      elevation: 4,
      pressElevation: 8,
      backgroundColor: AppColors.color000000,
      padding: EdgeInsets.zero,
      labelPadding: EdgeInsets.symmetric(horizontal: AppDimensions.mediumPadding),
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: AppColors.colorTransp),
          borderRadius:  BorderRadius.all(Radius.circular( AppDimensions.mediumPadding))),
      selectedColor: AppColors.colorTransp,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
  );
}
