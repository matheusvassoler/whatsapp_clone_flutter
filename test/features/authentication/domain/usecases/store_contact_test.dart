import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp/features/authentication/domain/entities/contact.dart';
import 'package:whatsapp/features/authentication/domain/repositories/auth_repository.dart';
import 'package:whatsapp/features/authentication/domain/usecases/store_contact.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

main() {
  MockAuthRepository mockAuthRepository;
  StoreContact storeContact;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    storeContact = StoreContact(mockAuthRepository);
  });

  final contact = Contact(phoneNumber: "+5519911111111", name: "Matheus", picture: "picture", deviceId: "AB23");
  final ddi = "+55";
  final phoneNumber = "19911111111";
  final name = "Matheus";
  final picture = "picture";
  final deviceId = "AB23";

  test('SHOULD store contact from the repository', () async {
    // ARRANGE
    when(mockAuthRepository.storeContact(any))
        .thenAnswer((realInvocation) async => Right(Unit));
    // ACT
    final result = await storeContact(
        Params(ddi: ddi, phoneNumber: phoneNumber, name: name, picture: picture, deviceId: deviceId)
    );
    // ASSERT
    expect(result, Right(Unit));
    verify(mockAuthRepository.storeContact(contact));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}