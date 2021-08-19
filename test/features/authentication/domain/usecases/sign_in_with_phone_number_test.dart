import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp/core/error/failure.dart';
import 'package:whatsapp/features/authentication/domain/repositories/auth_repository.dart';
import 'package:whatsapp/features/authentication/domain/usecases/sign_in_with_phone_number.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  SignInWithPhoneNumber signInWithPhoneNumber;
  MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signInWithPhoneNumber = SignInWithPhoneNumber(mockAuthRepository);
  });

  final smsCode = "123456";

  test('SHOULD sign in with phone number from the repository', () async {
    // ARRANGE
    when(mockAuthRepository.signInWithPhoneNumber(any))
        .thenAnswer((realInvocation) async => Right(Unit));
    when(mockAuthRepository.signOut())
        .thenAnswer((realInvocation) async => Right(Unit));
    // ACT
    final result = await signInWithPhoneNumber(Params(smsCode: smsCode));
    // ASSERT
    expect(result, Right(Unit));
    verify(mockAuthRepository.signInWithPhoneNumber(smsCode));
    verify(mockAuthRepository.signOut());
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('SHOULD not sign in with phone number from the repository WHEN has some problem with authentication', () async {
    // ARRANGE
    when(mockAuthRepository.signInWithPhoneNumber(any))
        .thenAnswer((realInvocation) async => Left(AuthenticationFailure()));
    when(mockAuthRepository.signOut())
        .thenAnswer((realInvocation) async => Right(Unit));
    // ACT
    final result = await signInWithPhoneNumber(Params(smsCode: smsCode));
    // ASSERT
    expect(result, Left(AuthenticationFailure()));
    verify(mockAuthRepository.signInWithPhoneNumber(smsCode));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
