import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:whatsapp/core/error/exception.dart';
import 'package:whatsapp/core/error/failure.dart';
import 'package:whatsapp/features/authentication/data/datasources/remote/auth_remote_data_source.dart';
import 'package:whatsapp/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({@required this.authRemoteDataSource});

  @override
  Future<Either<Failure, void>> verifyPhoneNumber(String phoneNumber) async {
    try {
      await authRemoteDataSource.verifyPhoneNumber(phoneNumber);
      return Right(Unit);
    } on InvalidPhoneException {
      return Left(InvalidPhoneFailure());
    } catch(e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signInWithPhoneNumber(String smsCode) async {
    try {
      await authRemoteDataSource.signInWithPhoneNumber(smsCode);
      return Right(Unit);
    } on AuthenticationException {
      return Left(AuthenticationFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await authRemoteDataSource.signOut();
      return Right(Unit);
    } on SignOutException {
      return Left(SignOutFailure());
    }
  }
}