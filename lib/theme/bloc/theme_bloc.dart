import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc() : super(ThemeMode.system) {
    on<ThemeSetInitial>(
      (event, emit) async {
        bool hasThemeDark = await isDark();
        emit(hasThemeDark ? ThemeMode.dark : ThemeMode.light);
      },
    );

    on<ThemeChangeEvent>(
      (event, emit) async {
        bool hasThemeDark = state == ThemeMode.dark;
        emit(hasThemeDark ? ThemeMode.light : ThemeMode.dark);
        setTheme(!hasThemeDark);
      },
    );
  }

  Future<bool> isDark() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final bool isDark = sharedPreferences.getBool('is_Dark') ?? false;
    return isDark;
  }

  Future<void> setTheme(bool isDark) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('is_Dark', isDark);
  }
}
