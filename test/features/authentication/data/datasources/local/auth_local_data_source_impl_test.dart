import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp/features/authentication/data/datasources/local/auth_local_data_source_impl.dart';
import 'package:whatsapp/features/authentication/data/models/contact_model.dart';

class MockHive extends Mock implements HiveInterface {}
class MockHiveBox extends Mock implements Box {}

main() {
  MockHive mockHive;
  MockHiveBox mockHiveBox;
  AuthLocalDataSourceImpl authLocalDataSourceImpl;
  ContactModel contactModel;

  setUp(() {
    mockHive = MockHive();
    mockHiveBox = MockHiveBox();
    authLocalDataSourceImpl = AuthLocalDataSourceImpl(mockHive);
    contactModel = ContactModel(phoneNumber: '+5511911111111', name: 'Matheus', picture: 'assets/picture', deviceId: '545FBE');
  });

  test('SHOULD call contact hive box to store the contact', () async {
    // ARRANGE
    when(mockHive.openBox(any)).thenAnswer((realInvocation) async => mockHiveBox);
    when(mockHiveBox.put(any, any)).thenAnswer((realInvocation) async => null);
    // ACT
    await authLocalDataSourceImpl.storeContact(contactModel);
    // ASSERT
    verify(mockHive.openBox('contact'));
    verify(mockHiveBox.put('+5511911111111', contactModel));
  });
}