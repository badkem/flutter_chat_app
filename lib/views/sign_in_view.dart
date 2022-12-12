import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/cubit/auth/auth_cubit.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {

                if (state is Unauthenticated) {
                  return SignInButton(
                    Buttons.Google,
                    onPressed: () {
                      context.read<AuthCubit>().signInWithGoogle();
                    },
                  );
                }

                if (state is Loading) {
                  return const CircularProgressIndicator();
                }

                if (state is Authenticated) {
                  return const Text('Authenticated');
                }

                if (state is AuthError) {
                  return Text(state.message);
                }

                return const Text('Unknown');
              },
            ),
          ],
        ),
      ),
    );
  }
}
