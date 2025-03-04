import 'package:authentication_bloc_firebase_2/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:authentication_bloc_firebase_2/features/auth/presentation/pages/sign_up_page.dart';
import 'package:authentication_bloc_firebase_2/features/common/widgets/background.dart';
import 'package:authentication_bloc_firebase_2/features/auth/presentation/widgets/email_field.dart';
import 'package:authentication_bloc_firebase_2/features/common/widgets/my_button.dart';
import 'package:authentication_bloc_firebase_2/features/common/widgets/my_outlined_btn.dart';
import 'package:authentication_bloc_firebase_2/features/auth/presentation/widgets/or_continue.dart';
import 'package:authentication_bloc_firebase_2/features/auth/presentation/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  Login({super.key});
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
      appBar: AppBar(title: const Text('Login')),
      body: Stack(
        children: [
          BackgroundWidget(),
          Center(
            child: BlocConsumer<AuthBloc, AuthState>(
              listenWhen: (previous, current) => current is ShowSnackBar,
              buildWhen: (previous, current) => current is! AuthActionState,
              listener: (context, state) {
                if (state is ShowSnackBar) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                        left: 20,
                        right: 20,
                      ),
                    ),
                  );
                }
              },
              // bloc: authBloc,
              builder: (context, state) {
                if (state is AuthLoading) {
                  return CircularProgressIndicator();
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 25),
                    //email
                    MyTextField(
                      controller: emailController,
                      hintText: 'Enter Email',
                      formKey: _emailformKey,
                      obscureText: false,
                    ),
                    SizedBox(height: 20),
                    PasswordField(
                      controller: passwordController,
                      hintText: "Enter Password",
                      formKey: _passwordformKey,
                    ),
                    SizedBox(height: 10),
                    //forgot password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.white38),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    //login button
                    MyButton(
                      onTap: () {
                        if (emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          context.read<AuthBloc>().add(
                            ShowSnackBarEvent(
                              message: "Email or password cannot be empty",
                            ),
                          );
                        } else {
                          context.read<AuthBloc>().add(
                            SignInWithEmailEvent(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        }
                        // context.read<AuthBloc>().add(
                        //   SignInWithEmailEvent(
                        //     email: emailController.text,
                        //     password: passwordController.text,
                        //   ),
                        // );
                      },
                      label: 'Login',
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
                        BlocProvider.of<AuthBloc>(
                          context,
                        ).add(SignInWithGoogleEvent());
                      },
                      label: 'Continue with Google',
                      // assetLocation: 'lib/images/google.svg',
                    ),
                    SizedBox(height: 20),
                    //register here button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('New?', style: TextStyle(color: Colors.grey[700])),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            // authBloc.add(NavigateToSignUpEvent());
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Register here',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
