part of 'theme_bloc.dart';

abstract class ThemeEvent {
  const ThemeEvent();

  List<Object> get props => [];
}

class ThemeSetInitial extends ThemeEvent {}

class ThemeChangeEvent extends ThemeEvent {
  final bool isDark;

  ThemeChangeEvent(this.isDark);

  @override
  List<Object> get props => [isDark];
}
