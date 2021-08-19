import 'package:dartz/dartz.dart';
import 'package:whatsapp/core/error/failure.dart';
import 'package:whatsapp/features/authentication/domain/entities/contact.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> verifyPhoneNumber(String phoneNumber);
  Future<Either<Failure, void>> signInWithPhoneNumber(String smsCode);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, void>> storeContact(Contact contact);
}