import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp/core/error/exception.dart';
import 'package:whatsapp/core/error/failure.dart';
import 'package:whatsapp/features/authentication/data/datasources/remote/auth_remote_data_source.dart';
import 'package:whatsapp/features/authentication/data/repositories/auth_repository_impl.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

main() {
  AuthRepositoryImpl repository;
  MockAuthRemoteDataSource mockAuthRemoteDataSource;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(authRemoteDataSource: mockAuthRemoteDataSource);
  });

  group('verifyPhoneNumber', () {
    String phoneNumber = "+5511911111111";

    test('SHOULD return Unit value WHEN verification is successful in the data source', () async {
      // ARRANGE
      when(mockAuthRemoteDataSource.verifyPhoneNumber(any)).thenAnswer((realInvocation) async => null);
      // ACT
      final result = await repository.verifyPhoneNumber(phoneNumber);
      // ASSERT
      verify(mockAuthRemoteDataSource.verifyPhoneNumber(phoneNumber));
      expect(result, equals(Right(Unit)));
    });

    test('SHOULD return InvalidPhoneFailure WHEN verification has a invalid phone number', () async {
      // ARRANGE
      when(mockAuthRemoteDataSource.verifyPhoneNumber(any)).thenThrow(InvalidPhoneException());
      // ACT
      final result = await repository.verifyPhoneNumber(phoneNumber);
      // ASSERT
      verify(mockAuthRemoteDataSource.verifyPhoneNumber(phoneNumber));
      expect(result, equals(Left(InvalidPhoneFailure())));
    });

    test('SHOULD return ServerFailure WHEN verification is not successful in the data source', () async {
      // ARRANGE
      when(mockAuthRemoteDataSource.verifyPhoneNumber(any)).thenThrow(ServerException());
      // ACT
      final result = await repository.verifyPhoneNumber(phoneNumber);
      // ASSERT
      verify(mockAuthRemoteDataSource.verifyPhoneNumber(phoneNumber));
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group('signInWithPhoneNumber', () {
    String smsCode = "123456";

    test('SHOULD return Unit value WHEN the credentials are valid', () async {
      // ARRANGE
      when(mockAuthRemoteDataSource.signInWithPhoneNumber(any)).thenAnswer((realInvocation) async => null);
      // ACT
      final result = await repository.signInWithPhoneNumber(smsCode);
      // ASSERT
      verify(mockAuthRemoteDataSource.signInWithPhoneNumber(smsCode));
      expect(result, equals(Right(Unit)));
    });

    test('SHOULD return AuthenticationFailure WHEN signIn is not successful in the data source', () async {
      // ARRANGE
      when(mockAuthRemoteDataSource.signInWithPhoneNumber(any)).thenThrow(AuthenticationException());
      // ACT
      final result = await repository.signInWithPhoneNumber(smsCode);
      // ASSERT
      verify(mockAuthRemoteDataSource.signInWithPhoneNumber(smsCode));
      expect(result, equals(Left(AuthenticationFailure())));
    });
  });

  group('signOut', () {
    test('SHOULD return Unit value WHEN logout is successful', () async {
      // ARRANGE
      when(mockAuthRemoteDataSource.signOut()).thenAnswer((realInvocation) async => null);
      // ACT
      final result = await repository.signOut();
      // ASSERT
      verify(mockAuthRemoteDataSource.signOut());
      expect(result, equals(Right(Unit)));
    });

    test('SHOULD return SignOutFailure WHEN logout is not successful', () async {
      // ARRANGE
      when(mockAuthRemoteDataSource.signOut()).thenThrow(SignOutException());
      // ACT
      final result = await repository.signOut();
      // ASSERT
      verify(mockAuthRemoteDataSource.signOut());
      expect(result, equals(Left(SignOutFailure())));
    });
  });
}