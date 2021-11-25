import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  static final darkTheme = ThemeData.dark().copyWith(
      appBarTheme:
          const AppBarTheme().copyWith(backgroundColor: AppColors.primaryColor),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: AppColors.primaryColorDark,
      ));

  static final lightTheme = ThemeData(
    primarySwatch: AppColors.primaryColor,
  );
}
