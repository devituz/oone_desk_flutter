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
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_)=> ThemeCubit(),

    child: BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return  MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              backgroundColor: state.maybeWhen(
                lightMode: () => AppColors.oq,
                darkMode: () => AppColors.bar_color,
                orElse: () => AppColors.oq,
              ),
            ),
          ),
          home: const Login(),
        );
      },
    ),
    );
  }
}









