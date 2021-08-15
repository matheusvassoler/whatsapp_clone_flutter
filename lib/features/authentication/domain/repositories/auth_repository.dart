import 'package:dartz/dartz.dart';
import 'package:whatsapp/core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> verifyPhoneNumber(String phoneNumber);
  Future<Either<Failure, void>> signInWithPhoneNumber(String smsCode);
  Future<Either<Failure, void>> signOut();
}