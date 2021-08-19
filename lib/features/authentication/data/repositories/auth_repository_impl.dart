import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:whatsapp/core/error/exception.dart';
import 'package:whatsapp/core/error/failure.dart';
import 'package:whatsapp/features/authentication/data/datasources/local/auth_local_data_source.dart';
import 'package:whatsapp/features/authentication/data/datasources/remote/auth_remote_data_source.dart';
import 'package:whatsapp/features/authentication/data/models/contact_model.dart';
import 'package:whatsapp/features/authentication/domain/entities/contact.dart';
import 'package:whatsapp/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl({@required this.authRemoteDataSource, @required this.authLocalDataSource});

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

  @override
  Future<Either<Failure, void>> storeContact(Contact contact) async {
    try {
      final contactModel = convertContactToContactModel(contact);
      await authRemoteDataSource.storeContact(contactModel);
      await authLocalDataSource.storeContact(contactModel);
      return Right(Unit);
    } catch(e) {
      return Left(DatasourceFailure());
    }
  }

  ContactModel convertContactToContactModel(Contact contact) {
    return ContactModel(
        phoneNumber: contact.phoneNumber,
        name: contact.name,
        picture: contact.picture,
        deviceId: contact.deviceId
    );
  }
}