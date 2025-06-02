import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_desk/screens/login/login.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'constants/colors/colors.dart';
import 'cubit/theme/theme_cubit.dart';
import 'cubit/theme/theme_state.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Open Hive box for storing theme data
  await Hive.openBox('themeBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_)=> ThemeCubit(),

    child: BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: state.maybeWhen(
                lightMode: () => AppColors.bar_color,
                darkMode: () => AppColors.rangsifatroq,
                orElse: () => AppColors.bar_color,
              ),
            ),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const Login(),
          themeMode: state.maybeWhen(
            lightMode: () => ThemeMode.light,
            darkMode: () => ThemeMode.dark,
            orElse: () => ThemeMode.system,
          ),
        );
      },
    ),
    );
  }
}









