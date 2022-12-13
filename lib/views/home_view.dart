import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/cubit/auth/auth_cubit.dart';
import 'package:flutter_chat_app/cubit/users/users_cubit.dart';

import 'sign_in_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SignInView()),
              (route) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL!),
              ),
              const SizedBox(width: 5),
              Text(user.displayName!)
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthCubit>().logout();
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: BlocBuilder<UserCubit, UsersState>(
          builder: (context, state) {
            return Center(
              child: StreamBuilder(
                stream: context.read<UserCubit>().getUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final user = snapshot.data!.docs[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user['photoUrl']),
                          ),
                          title: Text(user['name']),
                          subtitle: Text(user['email']),
                        );
                      },
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  return const Text('Empty');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
