import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp/core/error/exception.dart';
import 'package:whatsapp/features/authentication/data/datasources/remote/auth_remote_data_source_impl.dart';
import 'package:whatsapp/features/authentication/data/datasources/uri_requests.dart';
import 'package:whatsapp/features/authentication/data/models/contact_model.dart';

import '../../../../../mocks/mock_reader.dart';

class MockDioClient extends Mock implements Dio {}
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

main(){
  AuthRemoteDatSourceImpl dataSource;
  MockFirebaseAuth mockFirebaseAuth;
  MockDioClient mockDioClient;
  ContactModel contactModel;
  String contactJson;
  
  setUp(() {
    mockDioClient = MockDioClient();
    mockFirebaseAuth = MockFirebaseAuth();
    dataSource = AuthRemoteDatSourceImpl(auth: mockFirebaseAuth, client: mockDioClient);
    contactModel = ContactModel(phoneNumber: '+5511911111111', name: 'Matheus', picture: 'assets/picture', deviceId: '545FBE');
    contactJson = jsonEncode(contactModel.toJson());
  });
  
  test('SHOULD return nothing WHEN store contact for the first time is successful', () async {
    // ARRANGE
    when(mockDioClient.post(any, data: anyNamed('data')))
        .thenAnswer((realInvocation) async => Response(data: mock('new_contact.json'), statusCode: 201, requestOptions: RequestOptions(path: "")));
    // ACT
    await dataSource.storeContact(contactModel);
    // ASSERT
    verify(mockDioClient.post(UriRequests.contact, data: contactJson));
  });

  test('SHOULD return nothing WHEN store contact is just a change of device and it is successful', () async {
    // ARRANGE
    when(mockDioClient.post(any, data: anyNamed('data')))
        .thenAnswer((realInvocation) async => Response(data: mock('update_device_contact.json'), statusCode: 200, requestOptions: RequestOptions(path: "")));
    // ACT
    await dataSource.storeContact(contactModel);
    // ASSERT
    verify(mockDioClient.post(UriRequests.contact, data: contactJson));
  });

  test('SHOULD return BackendException WHEN store contact is not successful', () async {
    // ARRANGE
    when(mockDioClient.post(any, data: anyNamed('data')))
        .thenAnswer((realInvocation) async => Response(data: mock('new_contact.json'), statusCode: 400, requestOptions: RequestOptions(path: "")));
    // ACT
    final call = dataSource.storeContact;
    // ASSERT
    expect(call(contactModel), throwsA(TypeMatcher<ServerException>()));
    verify(mockDioClient.post(UriRequests.contact, data: contactJson));
  });
}