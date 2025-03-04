import 'package:authentication_bloc_firebase_2/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:authentication_bloc_firebase_2/firebase/firebase_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Out')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // try {
            //   await signOut();
            //   // Navigate to the next screen or show a success message
            // } catch (e) {
            //   print("Error signing iout: $e");
            // }
           context.read<AuthBloc>().add(SignOutEvent());
          },
          child: const Text('Sign out'),
        ),
      ),
    );
  }
}
