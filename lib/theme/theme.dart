import 'package:advdiary/theme/app_icon_theme.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_button_theme.dart';
import 'app_input_theme.dart';
import 'app_appbar_theme.dart';
import 'app_card_theme.dart';
import 'app_chip_theme.dart';
import 'app_divider_theme.dart';
import 'app_bottom_nav_theme.dart';

class CustomTheme {
  CustomTheme._();

  // ---------------- LIGHT THEME ----------------
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    primarySwatch: AppColors.primarySwatch,
    scaffoldBackgroundColor: AppColors.scaffoldBg,
    fontFamily: "Roboto",
/*    textTheme: TextTheme(
      headlineLarge: AppTextStyles.title(color: AppColors.headerText),
      headlineSmall: AppTextStyles.header(color: AppColors.headerText),
      bodyMedium: AppTextStyles.body(color: AppColors.bodyText),
      bodySmall: AppTextStyles.small(color: AppColors.mutedText),
      labelSmall: AppTextStyles.caption(color: AppColors.mutedText),
    ),*/
    appBarTheme: AppAppBarTheme.light,
    elevatedButtonTheme: AppButtonTheme.light,
    //inputDecorationTheme: AppInputTheme.light,
    cardTheme: AppCardTheme.light,
    chipTheme: AppChipTheme.light,
    dividerTheme: AppDividerTheme.light,
    bottomNavigationBarTheme: AppBottomNavTheme.light,
   // iconTheme: AppIconTheme.light
  );

  // ---------------- DARK THEME ----------------
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryDark,
    primarySwatch: AppColors.primarySwatch,
    scaffoldBackgroundColor: AppColors.scaffoldBgDark,
    fontFamily: "Roboto",
    /*textTheme: TextTheme(
      headlineLarge: AppTextStyles.title(color: AppColors.headerTextDark),
      headlineSmall: AppTextStyles.header(color: AppColors.headerTextDark),
      bodyMedium: AppTextStyles.body(color: AppColors.bodyTextDark),
      bodySmall: AppTextStyles.small(color: AppColors.mutedTextDark),
      labelSmall: AppTextStyles.caption(color: AppColors.mutedTextDark),
    ),*/
    appBarTheme: AppAppBarTheme.dark,
    elevatedButtonTheme: AppButtonTheme.dark,
    inputDecorationTheme: AppInputTheme.dark,
    cardTheme: AppCardTheme.dark,
    chipTheme: AppChipTheme.dark,
    dividerTheme: AppDividerTheme.dark,
    bottomNavigationBarTheme: AppBottomNavTheme.dark,
    iconTheme: AppIconTheme.dark
  );
}
