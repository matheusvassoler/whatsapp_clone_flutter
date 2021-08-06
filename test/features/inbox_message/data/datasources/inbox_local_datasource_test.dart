import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/core/error/exceptions.dart';
import 'package:whatsapp/features/inbox_message/data/datasources/inbox_local_data_source.dart';
import 'package:whatsapp/features/inbox_message/data/models/inbox_model.dart';
import 'package:whatsapp/features/inbox_message/domain/entities/inbox.dart';

import '../../../../mocks/mock_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  InboxLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;
  
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = InboxLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });
  
  group('getLastInboxes', () {
    final jsonMap = json.decode(mock("inboxes_cached.json")) as List;
    final inboxesModel = jsonMap.map((item) => InboxModel.fromJson(item)).toList();
    test('should return Inboxes from SharedPreferences when there is one in the cache', () async {
      when(mockSharedPreferences.getString(any)).thenReturn(mock("inboxes_cached.json"));
      final result = await dataSource.getLastInboxes();
      verify(mockSharedPreferences.getString(CACHED_INBOXES));
      expect(result, equals(inboxesModel));
    });

    test('should throw a CacheException when there is not a cached value', () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      final call = dataSource.getLastInboxes;
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });
  
  group('cacheInboxes', () {
    final inboxesModel = [InboxModel(receiptName: "Nome", receiptProfilePicture: "picture", lastMessage: "mensagem", messageDate: "10:48")];
    test('should call SharedPreferences to cache the data', () async {
      dataSource.cacheInboxes(inboxesModel);
      final expectedJsonString = json.encode(inboxesModel[0].toJson());
      verify(mockSharedPreferences.setString(CACHED_INBOXES, expectedJsonString));
    });
  });
}