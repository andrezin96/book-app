import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'google_auth_event.dart';
part 'google_auth_state.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
  GoogleAuthBloc() : super(GoogleAuthInitialState()) {
    on<GoogleAuthSignInEvent>(login);
    on<GoogleAuthSignOutEvent>(logout);
  }

  void login(GoogleAuthEvent event, Emitter<GoogleAuthState> emit) async {

    emit(GoogleAuthLoadingState());

    try {
      
      final firebaseAuth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      
      final UserCredential authResult =
          await firebaseAuth.signInWithCredential(authCredential);

      final User? user = authResult.user;
      emit(GoogleAuthSuccessState(user));

    } catch (e) {
      emit(GoogleAuthErrorState('$e'));
    }
  }

  void logout(GoogleAuthEvent event, Emitter<GoogleAuthState> emit) async {

    emit(GoogleAuthLoadingState());

    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      emit(GoogleAuthInitialState());

    } catch (e) {
      emit(GoogleAuthErrorState('Algo deu errado: $e'));
    }
  }
}
