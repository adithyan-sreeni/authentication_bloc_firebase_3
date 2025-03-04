import 'package:authentication_bloc_firebase_2/core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<SuccesType, Params> {
  Future<Either<Failure, dynamic>> call(Params params);
}
