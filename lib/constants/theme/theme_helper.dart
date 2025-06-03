import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_desk/cubit/theme/theme_cubit.dart';
import 'package:one_desk/cubit/theme/theme_state.dart';

class AppThemeHelper {
  final ThemeState state;

  AppThemeHelper._(this.state);

  factory AppThemeHelper.of(BuildContext context) {
    final themeState = context.read<ThemeCubit>().state; // <-- fix: `read` ishlatiladi
    return AppThemeHelper._(themeState);
  }


  /// Faqat `Text` ranglari
  Color get textColor => state.maybeWhen(
    lightMode: () => Colors.black87,
    darkMode: () => Colors.white,
    orElse: () => Colors.black87,
  );

  /// Umumiy `Scaffold` yoki `body` fon rangi
  Color get bodyColor => state.maybeWhen(
    lightMode: () => Colors.white,
    darkMode: () => const Color(0xFF121212),
    orElse: () => Colors.white,
  );

  /// Faqat `Icon` ranglari
  Color get iconColor => state.maybeWhen(
    lightMode: () => Colors.black54,
    darkMode: () => Colors.white70,
    orElse: () => Colors.black54,
  );

  /// Misol uchun, umumiy sarlavha stili
  TextStyle get titleStyle => TextStyle(
    color: textColor,
  );
}
