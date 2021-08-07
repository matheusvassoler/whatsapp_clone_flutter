import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp/core/error/exceptions.dart';
import 'package:whatsapp/features/inbox_message/data/datasources/inbox_remote_data_source.dart';
import 'package:whatsapp/features/inbox_message/data/models/inbox_model.dart';

import '../../../../mocks/mock_reader.dart';

class MockDioClient extends Mock implements Dio {}

void main() {
  InboxRemoteDataSourceImpl dataSource;
  MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    dataSource = InboxRemoteDataSourceImpl(client: mockDioClient);
  });

  void setUpMockDioClientSuccess200() {
    when(mockDioClient.get(any, queryParameters: anyNamed('queryParameters')))
        .thenAnswer((realInvocation) async => Response(data: mock("inbox.json"), statusCode: 200));
  }

  void setUpMockDioClientSFailure404() {
    when(mockDioClient.get(any, queryParameters: anyNamed('queryParameters')))
        .thenAnswer((realInvocation) async => Response(data: "Something went wrong", statusCode: 404));
  }
  
  group('getInboxes', () {
    final inboxOwnerId = '3443';
    final jsonMap = json.decode(mock("inbox.json")) as List;
    final inboxesModel = jsonMap.map((item) => InboxModel.fromJson(item)).toList();
    
    test('should perform a GET request on a URL with number being the endpoint', () async {
      setUpMockDioClientSuccess200();
      dataSource.getInboxes(inboxOwnerId);
      verify(mockDioClient.get("http://192.168.0.10:8080/inbox", queryParameters: {"contactId": inboxOwnerId}));
    });
    
    test('should return InboxModel list when response code is 200 (success)', () async {
      setUpMockDioClientSuccess200();

      final result = await dataSource.getInboxes(inboxOwnerId);
      expect(result, inboxesModel);
    });
    
    test('should throw a ServerException when the response code is 404 or other', () async {
      setUpMockDioClientSFailure404();
      final call = dataSource.getInboxes;
      expect(() => call(inboxOwnerId), throwsA(TypeMatcher<ServerException>()));
    });
  });
}