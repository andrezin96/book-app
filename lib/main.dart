import 'package:book_app/models/book/bloc/book_bloc.dart';
import 'package:book_app/screens/auth/auth_page.dart';
import 'package:book_app/screens/auth/user_login_state.dart';
import 'package:book_app/screens/favorite/bloc/favorite_bloc.dart';
import 'package:book_app/screens/home/components/search_textfield/bloc/textfield_bloc.dart';
import 'package:book_app/screens/home/home_page.dart';
import 'package:book_app/screens/favorite/favorite_page.dart';
import 'package:book_app/screens/info/info_page.dart';
import 'package:book_app/screens/read/bloc/read_bloc.dart';
import 'package:book_app/screens/read/read_page.dart';
import 'package:book_app/screens/tbr/bloc/tbr_bloc.dart';
import 'package:book_app/screens/tbr/tbr_page.dart';
import 'package:book_app/services/google_auth/bloc/google_auth_bloc.dart';
import 'package:book_app/firebase_options.dart';
import 'package:book_app/theme/bloc/theme_bloc.dart';
import 'package:book_app/theme/color_schemes.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<GoogleAuthBloc>(create: (context) => GoogleAuthBloc()),
        BlocProvider<BookBloc>(create: (context) => BookBloc()),
        BlocProvider<FavoriteBloc>(create: (context) => FavoriteBloc()),
        BlocProvider<ReadBloc>(create: (context) => ReadBloc()),
        BlocProvider<TbrBloc>(create: (context) => TbrBloc()),
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()..add(ThemeSetInitial())),
        BlocProvider<TextfieldBloc>(create: (context) => TextfieldBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeMode>(
      builder: (context, state) {
        return MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: state,
          debugShowCheckedModeBanner: false,
          routes: {
            '/loginstate': (context) => const LoginState(),
            '/auth': (context) => const AuthPage(),
            '/home': (context) => HomePage(),
            '/favorite': (context) => const FavoritePage(),
            '/read': (context) => const ReadPage(),
            '/tbr': (context) => const TbrPage(),
            '/info': (context) => const InfoPage(),
          },
          home: const LoginState(),
        );
      },
    );
  }
}
