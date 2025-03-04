import 'package:authentication_bloc_firebase_2/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:authentication_bloc_firebase_2/features/common/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Out')),
      body: BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (previous, current) => current is! AuthActionState,
        builder: (context, state) {
          return Stack(
            children: [
              BackgroundWidget(),
              Center(
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
              if (state is AuthLoading)
                IgnorePointer(
                  ignoring: true,
                  child: Container(
                    color: const Color.fromARGB(155, 0, 0, 0),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
