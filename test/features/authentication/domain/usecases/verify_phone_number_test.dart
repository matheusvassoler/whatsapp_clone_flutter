import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp/features/authentication/domain/repositories/auth_repository.dart';
import 'package:whatsapp/features/authentication/domain/usecases/verify_phone_number.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  VerifyPhoneNumber verifyPhoneNumber;
  MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    verifyPhoneNumber = VerifyPhoneNumber(mockAuthRepository);
  });

  final ddi = "55";
  final phoneNumber = "19911111111";

  test('SHOULD verify phone number from the repository', () async {
    // ARRANGE
    when(mockAuthRepository.verifyPhoneNumber(any))
        .thenAnswer((realInvocation) async => Right(Unit));
    // ACT
    final result = await verifyPhoneNumber(Params(ddi: ddi, phoneNumber: phoneNumber));
    // EXPECT
    expect(result, Right(Unit));
    verify(mockAuthRepository.verifyPhoneNumber("+5519911111111"));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}