import 'package:authentication_bloc_firebase_2/core/errors/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUp(String email, String password);
  Future<Either<Failure, User>> signIn(String email, String password);
  Future<Either<Failure, User>> signInWithGoogle();
  Future<Either<Failure, String>> signOut();
}
