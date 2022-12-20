import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/cubit/auth/auth_cubit.dart';
import 'package:flutter_chat_app/data/repositories/auth_repositories.dart';
import 'package:flutter_chat_app/data/repositories/store_repositories.dart';
import 'package:flutter_chat_app/views/home_view.dart';
import 'package:flutter_chat_app/views/sign_in_view.dart';

import 'cubit/chat/chat_cubit.dart';
import 'cubit/users/users_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final options = DefaultFirebaseOptions.currentPlatform;

  await Firebase.initializeApp(options: options);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthCubit(AuthRepository(), StoreRepositories()),
          ),
          BlocProvider(create: (context) => UserCubit(StoreRepositories())),
          BlocProvider(create: (context) => ChatCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const HomeView();
              }

              return const SignInView();
            },
          ),
        ),
      ),
    );
  }
}
