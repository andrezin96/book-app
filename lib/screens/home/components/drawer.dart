import 'package:book_app/screens/favorite/bloc/favorite_bloc.dart';
import 'package:book_app/screens/read/bloc/read_bloc.dart';
import 'package:book_app/screens/tbr/bloc/tbr_bloc.dart';
import 'package:book_app/services/google_auth/bloc/google_auth_bloc.dart';
import 'package:book_app/theme/bloc/theme_bloc.dart';
import 'package:book_app/widgets/scaffold_messenger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  onTap(BuildContext context) {
    if (context.read<ThemeBloc>().state == ThemeMode.dark) {
      context.read<ThemeBloc>().add(ThemeChangeEvent(true));
    } else {
      context.read<ThemeBloc>().add(ThemeChangeEvent(true));
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage('${currentUser.photoURL}'),
                ),
                Text('${currentUser.displayName}'),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.star, color: Colors.yellow.shade600),
                const SizedBox(width: 10),
                const Text('Favoritos'),
              ],
            ),
            onTap: () {
              context.read<FavoriteBloc>().add(FavoriteListEvent());
              Navigator.pushNamed(context, '/favorite');
            },
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.bookmark_added, color: Colors.green),
                SizedBox(width: 10),
                Text('Lidos'),
              ],
            ),
            onTap: () {
              context.read<ReadBloc>().add(ReadListEvent());
              Navigator.pushNamed(context, '/read');
            },
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.bookmark_add, color: Colors.blue),
                SizedBox(width: 10),
                Text('TBR'),
              ],
            ),
            onTap: () {
              context.read<TbrBloc>().add(TbrListEvent());
              Navigator.pushNamed(context, '/tbr');
            },
          ),
          const Divider(),
          ListTile(
            title: BlocBuilder<ThemeBloc, ThemeMode>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Icon(state == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode),
                          const SizedBox(width: 10),
                          const Text('Tema'),
                        ],
                      ),
                    ),
                    Switch(
                      value: context.read<ThemeBloc>().state == ThemeMode.dark,
                      onChanged: (value) {
                        context.read<ThemeBloc>().add(ThemeChangeEvent(value));
                      },
                    ),
                  ],
                );
              },
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.logout, color: Colors.red),
                SizedBox(width: 10),
                Text('Sair'),
              ],
            ),
            onTap: () {
              context.read<GoogleAuthBloc>().add(GoogleAuthSignOutEvent());
              SMessenger().menssenger(context, 'Desconectado com Sucesso!', Colors.green);
              Navigator.pushReplacementNamed(context, '/loginstate');
            },
          ),
        ],
      ),
    );
  }
}
