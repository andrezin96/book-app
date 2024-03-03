part of 'google_auth_bloc.dart';

abstract class GoogleAuthState extends Equatable {
  const GoogleAuthState();

  @override
  List<Object> get props => [];
}

class GoogleAuthInitialState extends GoogleAuthState {}

class GoogleAuthLoadingState extends GoogleAuthState {}

class GoogleAuthSuccessState extends GoogleAuthState {
  final User? user;

  const GoogleAuthSuccessState(this.user);

  @override
  List<Object> get props => [user!];
}

class GoogleAuthErrorState extends GoogleAuthState {
  final String error;

  const GoogleAuthErrorState(this.error);

  @override
  List<Object> get props => [error];
}
 