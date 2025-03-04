import 'package:authentication_bloc_firebase_2/core/errors/failure.dart';
import 'package:authentication_bloc_firebase_2/features/auth/domain/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRepositoryImpl(this.firebaseAuth, this.googleSignIn);

  @override
  Future<Either<Failure, User>> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return Right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(_mapFirebaseError(e)));
    } catch (e) {
      return Left(ServerFailure("Unexpected error occurred"));
    }
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Email is already in use';
      case 'weak-password':
        return 'Password is too weak';
      case 'invalid-email':
        return 'Invalid email address';
      default:
        return 'Authentication failed';
    }
  }

  @override
  Future<Either<Failure, String>> signOut() async {
    try {
      await firebaseAuth.signOut();
      return Right("Signed out successfully");
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message!));
    } catch (e) {
      return Left(ServerFailure("Unexpected error occurred"));
    }
  }

  @override
  Future<Either<Failure, User>> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return Right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(_mapFirebaseSigninError(e)));
    } catch (e) {
      return Left(ServerFailure("Unexpected error occurred"));
    }
  }

  String _mapFirebaseSigninError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'invalid-email':
        return 'Invalid email address';
      case 'user-disabled':
        return 'This user has been disabled';
      default:
        return 'Authentication failed';
    }
  }

  @override
  Future<Either<Failure, User>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return Left(ServerFailure("Google sign-in was canceled"));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );
      return Right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(_mapFirebaseSigninError(e)));
    } catch (e) {
      return Left(ServerFailure("Unexpected error occurred"));
    }
  }
}
