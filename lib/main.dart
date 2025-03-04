import 'package:authentication_bloc_firebase_2/authwrapper.dart';
import 'package:authentication_bloc_firebase_2/core/theme/dark_theme.dart';
import 'package:authentication_bloc_firebase_2/features/auth/data/auth_repo_impl.dart';
import 'package:authentication_bloc_firebase_2/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:authentication_bloc_firebase_2/features/auth/presentation/widgets/gbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    BlocProvider(
      create:
          (context) => AuthBloc(
            authRepository: AuthRepositoryImpl(
              FirebaseAuth.instance,
              GoogleSignIn(),
            ),
          )..add(AuthCheckRequested()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication with Firebase',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: AuthWrapper(),
    );
  }
}
