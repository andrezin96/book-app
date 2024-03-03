import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: lightColorScheme
);

ThemeData darkTheme = ThemeData(
  colorScheme: darkColorScheme
);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF0060AA),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFD3E4FF),
  onPrimaryContainer: Color(0xFF001C38),
  secondary: Color(0xFF545F70),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD8E3F8),
  onSecondaryContainer: Color(0xFF111C2B),
  tertiary: Color(0xFF5A53A8),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFE3DFFF),
  onTertiaryContainer: Color(0xFF150463),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFDFCFF),
  onBackground: Color(0xFF1A1C1E),
  surface: Color(0xFFFDFCFF),
  onSurface: Color(0xFF1A1C1E),
  surfaceVariant: Color(0xFFDFE2EB),
  onSurfaceVariant: Color(0xFF43474E),
  outline: Color(0xFF73777F),
  onInverseSurface: Color(0xFFF1F0F4),
  inverseSurface: Color(0xFF2F3033),
  inversePrimary: Color(0xFFA3C9FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF0060AA),
  outlineVariant: Color(0xFFC3C6CF),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFA3C9FF),
  onPrimary: Color(0xFF00315C),
  primaryContainer: Color(0xFF004882),
  onPrimaryContainer: Color(0xFFD3E4FF),
  secondary: Color(0xFFBCC7DB),
  onSecondary: Color(0xFF263141),
  secondaryContainer: Color(0xFF3C4758),
  onSecondaryContainer: Color(0xFFD8E3F8),
  tertiary: Color(0xFFC5C0FF),
  onTertiary: Color(0xFF2B2276),
  tertiaryContainer: Color(0xFF423B8E),
  onTertiaryContainer: Color(0xFFE3DFFF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF1A1C1E),
  onBackground: Color(0xFFE3E2E6),
  surface: Color(0xFF1A1C1E),
  onSurface: Color(0xFFE3E2E6),
  surfaceVariant: Color(0xFF43474E),
  onSurfaceVariant: Color(0xFFC3C6CF),
  outline: Color(0xFF8D9199),
  onInverseSurface: Color(0xFF1A1C1E),
  inverseSurface: Color(0xFFE3E2E6),
  inversePrimary: Color(0xFF0060AA),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFA3C9FF),
  outlineVariant: Color(0xFF43474E),
  scrim: Color(0xFF000000),
);
