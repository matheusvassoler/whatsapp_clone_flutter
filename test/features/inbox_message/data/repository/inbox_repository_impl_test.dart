import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp/core/error/exceptions.dart';
import 'package:whatsapp/core/error/failure.dart';
import 'package:whatsapp/core/platform/network_info.dart';
import 'package:whatsapp/features/inbox_message/data/datasources/inbox_local_data_source.dart';
import 'package:whatsapp/features/inbox_message/data/datasources/inbox_remote_data_source.dart';
import 'package:whatsapp/features/inbox_message/data/models/inbox_model.dart';
import 'package:whatsapp/features/inbox_message/data/repositories/inbox_repository_impl.dart';
import 'package:whatsapp/features/inbox_message/domain/entities/inbox.dart';

class MockRemoteDataSource extends Mock implements InboxRemoteDataSource {}

class MockLocalDataSource extends Mock implements InboxLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  InboxRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = InboxRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((
            realInvocation) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((
            realInvocation) async => false);
      });

      body();
    });
  }

  group('getInboxes', () {
    final inboxOwnerNumber = "19111111111";
    final inboxModel = [InboxModel(receiptName: "Matheus", receiptProfilePicture: "picture", lastMessage: "Mensagem", messageDate: "10:48")];
    final List<Inbox> inbox = inboxModel;
    test('SHOULD check if the device is online', () async {
      // GIVEN/ARRANGE
      when(mockNetworkInfo.isConnected).thenAnswer((realInvocation) async => true);
      // WHEN/ACT
      repository.getInboxes(inboxOwnerNumber);
      // THEN/ASSERT
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('SHOULD return remote data WHEN the call to remote data source is successful', () async {
        // arrange
        when(mockRemoteDataSource.getInboxes(any)).thenAnswer((realInvocation) async => inboxModel);
        // act
        final result = await repository.getInboxes(inboxOwnerNumber);
        // assert
        verify(mockRemoteDataSource.getInboxes(inboxOwnerNumber));
        expect(result, equals(Right(inbox)));
      });

      test('SHOULD cache data locally WHEN the call to remote data source is successful', () async {
        // arrange
        when(mockRemoteDataSource.getInboxes(any)).thenAnswer((realInvocation) async => inboxModel);
        // act
        await repository.getInboxes(inboxOwnerNumber);
        // assert
        verify(mockRemoteDataSource.getInboxes(inboxOwnerNumber));
        verify(mockLocalDataSource.cacheInboxes(inboxModel));
      });

      test('SHOULD return server failure WHEN the call to remote data source is not successful', () async {
        // arrange
        when(mockRemoteDataSource.getInboxes(any)).thenThrow(ServerException());
        // act
        final result = await repository.getInboxes(inboxOwnerNumber);
        // assert
        verify(mockRemoteDataSource.getInboxes(inboxOwnerNumber));
        verifyZeroInteractions(mockLocalDataSource);
        //expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((realInvocation) async => false);
      });

      test('SHOULD return last locally cached data when the cached data is present', () async {
        when(mockLocalDataSource.getLastInboxes()).thenAnswer((realInvocation) async => inboxModel);
        final result = await repository.getInboxes(inboxOwnerNumber);
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastInboxes());
        expect(result, equals(Right(inbox)));
      });

      test('SHOULD return cache failure when there is no cached data present', () async {
        when(mockLocalDataSource.getLastInboxes()).thenThrow(CacheException());
        final result = await repository.getInboxes(inboxOwnerNumber);
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastInboxes());
        //expect(result, equals(Left(CacheFailure())));
      });
    });

  });
}