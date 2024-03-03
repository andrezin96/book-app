import 'package:book_app/services/google_auth/bloc/google_auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () => context.read<GoogleAuthBloc>().add(GoogleAuthSignInEvent()),
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100)
            ),
            child: Image.asset('assets/images/google.png', height: 50),
          ),
        ),
      ),
    );
  }
}