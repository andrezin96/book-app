import 'package:book_app/screens/home/home_page.dart';
import 'package:book_app/services/google_auth/bloc/google_auth_bloc.dart';
import 'package:book_app/widgets/buttons/google_button.dart';
import 'package:book_app/widgets/scaffold_messenger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GoogleAuthBloc, GoogleAuthState>(
        listener: (context, state) {
          if (state is GoogleAuthSuccessState) {
            return SMessenger().menssenger(context, 'Conectado com Sucesso!', Colors.green);
          }
          if (state is GoogleAuthErrorState) {
            return SMessenger().menssenger(context, 'Algo deu errado!', Colors.red);
          }
        },
        builder: (context, state) {
          if (state is GoogleAuthInitialState) {
            return Scaffold(
              body: SizedBox.expand(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/icon/icon.png', height: 180),
                    const SizedBox(height: 20),
                    const Text(
                      'Entre com sua conta do Google',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    const GoogleButton(),
                  ],
                ),
              ),
            );
          }

          if (state is GoogleAuthLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is GoogleAuthErrorState) {
            return Center(
              child: Text('Algo deu errado, ${state.error}'),
            );
          }

          if (state is GoogleAuthSuccessState) {
            return HomePage();
          }
          return const Text('Algo deu errado');
        },
      ),
    );
  }
}
