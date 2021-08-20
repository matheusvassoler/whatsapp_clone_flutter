import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp/core/error/failure.dart';
import 'package:whatsapp/features/authentication/domain/usecases/verify_phone_number.dart';
import 'package:whatsapp/features/authentication/presentation/cubit/authentication_cubit.dart';

class MockVerifyPhoneNumber extends Mock implements VerifyPhoneNumber {}

main() {
  MockVerifyPhoneNumber mockVerifyPhoneNumber;
  AuthenticationCubit authenticationCubit;

  setUp(() {
    mockVerifyPhoneNumber = MockVerifyPhoneNumber();
    authenticationCubit = AuthenticationCubit(mockVerifyPhoneNumber);
  });

  test('initialState SHOULD by Empty', () {
    // ASSERT
    expect(authenticationCubit.state, equals(Empty()));
  });

  group('sendSmsCode', () {
    final ddi = "+55";
    final phoneNumber = "19911111111";

    blocTest<AuthenticationCubit, AuthenticationState>(
      'SHOULD emits [Loading, SmsCodeSent] WHEN sending sms code from the verify phone number use case was successful',
      // ARRANGE
      build: () => authenticationCubit,
      setUp: () {
        when(mockVerifyPhoneNumber(any)).thenAnswer((realInvocation) async => Right(Unit));
      },
      // ACT
      act: (cubit) => cubit.sendSmsCode(ddi, phoneNumber),
      // ASSERT
      expect: () => [
        Loading(),
        SmsCodeSent()
      ],
      verify: (_) =>
          verify(mockVerifyPhoneNumber(Params(ddi: ddi, phoneNumber: phoneNumber)))
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'SHOULD emits [Loading, Error] WHEN phone number is invalid',
      // ARRANGE
      build: () => authenticationCubit,
      setUp: () {
        when(mockVerifyPhoneNumber(any)).thenAnswer((realInvocation) async => Left(InvalidPhoneFailure()));
      },
      // ACT
      act: (cubit) => cubit.sendSmsCode(ddi, phoneNumber),
      // ASSERT
      expect: () => [
        Loading(),
        Error(failure: InvalidPhoneFailure())
      ],
      verify: (_) =>
          verify(mockVerifyPhoneNumber(Params(ddi: ddi, phoneNumber: phoneNumber)))
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
        'SHOULD emits [Loading, Error] WHEN server error happens',
        // ARRANGE
        build: () => authenticationCubit,
        setUp: () {
          when(mockVerifyPhoneNumber(any)).thenAnswer((realInvocation) async => Left(InvalidPhoneFailure()));
        },
        // ACT
        act: (cubit) => cubit.sendSmsCode(ddi, phoneNumber),
        // ASSERT
        expect: () => [
          Loading(),
          Error(failure: ServerFailure())
        ],
        verify: (_) =>
            verify(mockVerifyPhoneNumber(Params(ddi: ddi, phoneNumber: phoneNumber)))
    );
  });
}