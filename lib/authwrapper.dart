import 'package:authentication_bloc_firebase_2/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:authentication_bloc_firebase_2/features/auth/presentation/pages/login_page.dart';
import 'package:authentication_bloc_firebase_2/features/auth/presentation/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // User is signed in
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.popUntil(context, (route) => route.isFirst);
          });
          return Home();
          // return Home();
        } else {
          // User is not signed in
          return Login();
        }
      },
    );
  }
}

// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         if (state is AuthLoading) {
//           return Center(child: CircularProgressIndicator());
//         } else if (state is Authenticated) {
//           // Ensure the user doesn't navigate back to the login page
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             Navigator.popUntil(context, (route) => route.isFirst);
//           });
//           return Home();
//         } else {
//           return Login();
//         }
//       },
//     );
//   }
// }
