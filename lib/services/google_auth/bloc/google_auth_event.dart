part of 'google_auth_bloc.dart';

abstract class GoogleAuthEvent {}

class GoogleAuthSignInEvent extends GoogleAuthEvent {}

class GoogleAuthSignOutEvent extends GoogleAuthEvent {}
