import 'package:authentication_bloc_firebase_2/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:authentication_bloc_firebase_2/features/auth/presentation/widgets/email_field.dart';
import 'package:authentication_bloc_firebase_2/features/auth/presentation/widgets/or_continue.dart';
import 'package:authentication_bloc_firebase_2/features/auth/presentation/widgets/password_field.dart';
import 'package:authentication_bloc_firebase_2/features/common/widgets/background.dart';
import 'package:authentication_bloc_firebase_2/features/common/widgets/my_button.dart';
import 'package:authentication_bloc_firebase_2/features/common/widgets/my_outlined_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _emailformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordformKey = GlobalKey<FormState>();
  // final AuthBloc authBloc = AuthBloc(
  //   userLogIn: UserLogIn(
  //     authRepository: AuthRepoImplementation(
  //       authRemoteDataSource: AuthRemoteDataSourceImpl(
  //         firebaseAuth: FirebaseAuth.instance,
  //         googleSignIn: GoogleSignIn(),
  //       ),
  //     ),
  //   ),
  //   userSignUp: UserSignUp(
  //     authRepository: AuthRepoImplementation(
  //       authRemoteDataSource: AuthRemoteDataSourceImpl(
  //         firebaseAuth: FirebaseAuth.instance,
  //         googleSignIn: GoogleSignIn(),
  //       ),
  //     ),
  //   ),
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Sign Up')),
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          // bloc: authBloc,
          listenWhen: (previous, current) => current is ShowSnackBar,
          buildWhen: (previous, current) => current is! AuthActionState,
          listener: (context, state) {
            if (state is ShowSnackBar) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.only(
                    bottom:
                        MediaQuery.of(context).viewInsets.bottom +
                        20, // Add padding for keyboard
                    left: 20,
                    right: 20,
                  ),
                  // backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            // if (state is AuthLoading) {
            //   return Center(child: CircularProgressIndicator());
            // }
            return Stack(
              children: [
                BackgroundWidget(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                    const SizedBox(height: 20),
                    MyTextField(
                      controller: emailController,
                      hintText: 'Enter Email',
                      formKey: _emailformKey,
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
                    PasswordField(
                      controller: passwordController,
                      hintText: "Enter Password",
                      formKey: _passwordformKey,
                    ),
                    const SizedBox(height: 20),
                    MyButton(
                      onTap: () {
                        if (_emailformKey.currentState!.validate() &&
                            _passwordformKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            SignUpWithEmailEvent(
                              email: emailController.text,
                              password: passwordController.text,
                              name: "none",
                            ),
                          );
                        }
                      },
                      label: 'Sign Up',
                    ),
                    SizedBox(height: 20),
                    //or continue with
                    Continue(),
                    SizedBox(height: 20),
                    //google button
                    MyOutlinedButton(
                      onTap: () async {
                        // try {
                        //   await signInWithGoogle();
                        //   // Navigate to the next screen or show a success message
                        // } catch (e) {
                        //   print("Error signing in with Google: $e");
                        // }
                        context.read<AuthBloc>().add(SignInWithGoogleEvent());
                      },
                      label: 'Create Account with Google',
                      // assetLocation: 'lib/images/google.svg',
                    ),
                    SizedBox(height: 20),
                    //register here button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            // authBloc.add(NavigateToLoginEvent());
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Login here',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
      ),
    );
  }
}
