import 'package:pokedex/core/constants/colors.dart';
import 'package:flutter/material.dart';

abstract class AppThemeData {
  ThemeData get materialThemeData;
  Color get primary;
  Color get error;
  Color get white;
  Color get black;
  Color get grey;
  Color get cancel;
  Color get avatarBackground;
  TextStyle get appBarTitle;
  TextStyle get titleSmall;
  TextStyle get titleMedium;
  TextStyle get titleBig;
  TextStyle get normalText;
  TextStyle get bold;
  InputDecoration get roundedBorderContainer;
}

// LIGHT MODE DATA *********************************************
class AppLightThemeData extends AppThemeData {
  AppLightThemeData({
    required this.primary,
  });

  @override
  Color primary;

  @override
  ThemeData get materialThemeData => ThemeData(
        brightness: Brightness.light,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
        ),
        fontFamily: 'Poppins',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(white),
          )
        ),
        colorScheme: ColorScheme.light(
          primary: primary,
        ),
        dividerTheme: DividerThemeData(color: primary),
      );

  @override
  Color get error => AppColors.error;
  @override
  Color get white => AppColors.white;
  @override
  Color get black => AppColors.black;
  @override
  Color get grey => AppColors.grey;
  @override
  Color get cancel => const Color.fromARGB(200, 100, 100, 100);
  @override
  Color get avatarBackground => AppColors.grey;

  @override
  TextStyle get appBarTitle => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: white,
      );
  @override
  @override
  TextStyle get titleSmall => TextStyle(
      fontSize: 16.5, fontWeight: FontWeight.w600, color: AppColors.grey);
  @override
  TextStyle get titleMedium => TextStyle(
      fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.grey);
  @override
  TextStyle get titleBig => TextStyle(
      fontSize: 25, fontWeight: FontWeight.w600, color: AppColors.grey);

  @override
  TextStyle get normalText => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
      );

  @override
  TextStyle get bold => const TextStyle(
        fontWeight: FontWeight.bold,
      );

  @override
  InputDecoration get roundedBorderContainer => InputDecoration(
        fillColor: AppColors.white.withOpacity(0.95),
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      );
}

// DARK MODE DATA *********************************************
class AppDarkThemeData extends AppThemeData {
  AppDarkThemeData({
    required this.primary,
  });

  @override
  Color primary;

  @override
  ThemeData get materialThemeData => ThemeData(
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
        ),
        fontFamily: 'Poppins',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(AppColors.white),
          )
        ),
        colorScheme: ColorScheme.dark(
          primary: primary,
          // secondary: AppColors.secondary,
        ),
        dividerTheme: DividerThemeData(color: primary),
      );

  @override
  Color get error => AppColors.errorDark;
  @override
  Color get white => AppColors.whiteDark;
  @override
  Color get black => AppColors.blackDark;
  @override
  Color get grey => AppColors.greyDark;
  @override
  Color get cancel => const Color.fromARGB(200, 100, 100, 100);
  @override
  Color get avatarBackground => AppColors.greyDark;

  @override
  TextStyle get appBarTitle => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: AppColors.whiteDark,
      );
  @override
  TextStyle get titleSmall => TextStyle(
      fontSize: 16.5, fontWeight: FontWeight.w600, color: AppColors.greyDark);
  @override
  TextStyle get titleMedium => TextStyle(
      fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.greyDark);
  @override
  TextStyle get titleBig => TextStyle(
      fontSize: 25, fontWeight: FontWeight.w600, color: AppColors.greyDark);
  @override
  @override
  TextStyle get normalText => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
      );

  @override
  TextStyle get bold => const TextStyle(
        fontWeight: FontWeight.bold,
      );

  @override
  InputDecoration get roundedBorderContainer => InputDecoration(
        fillColor: AppColors.whiteDark.withOpacity(0.95),
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      );
}