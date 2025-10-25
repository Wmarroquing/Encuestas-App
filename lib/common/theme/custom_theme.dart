import 'package:devel_app/common/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    colorScheme: ColorScheme.fromSeed(seedColor: CustomColors.primary).copyWith(
      primary: CustomColors.primary,
      primaryContainer: CustomColors.primary.withValues(alpha: 0.8),
      secondary: CustomColors.accent,
      secondaryContainer: CustomColors.accent.withValues(alpha: 0.8),
      surface: CustomColors.background,
      error: CustomColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: CustomColors.textPrimary,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: outlineInputBorder(CustomColors.gray),
      focusedBorder: outlineInputBorder(CustomColors.primary),
      errorBorder: outlineInputBorder(CustomColors.error),
      enabledBorder: outlineInputBorder(CustomColors.gray),
      disabledBorder: outlineInputBorder(CustomColors.gray),
      errorStyle: const TextStyle(color: CustomColors.error),
      hintStyle: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: CustomColors.textSecondary,
      ),
      activeIndicatorBorder: const BorderSide(color: CustomColors.primary),
      suffixIconColor: CustomColors.textSecondary,
      prefixIconColor: CustomColors.textSecondary,
    ),
    buttonTheme: const ButtonThemeData(buttonColor: CustomColors.primary),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.primary,
        foregroundColor: CustomColors.background,
        overlayColor: CustomColors.accent,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: CustomColors.background,
        foregroundColor: CustomColors.primary,
        overlayColor: CustomColors.accent,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      showDragHandle: true,
      dragHandleSize: Size(100.0, 4.0),
      backgroundColor: CustomColors.background,
    ),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: CustomColors.accent,
      dividerColor: Colors.transparent,
      labelColor: CustomColors.accent,
      unselectedLabelColor: CustomColors.textSecondary,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      indicator: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
  );

  static OutlineInputBorder outlineInputBorder(final Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: borderColor),
    );
  }
}
