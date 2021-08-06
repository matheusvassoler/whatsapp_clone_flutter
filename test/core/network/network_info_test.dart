import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp/core/network/network_info.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfo;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });
  
  group('isConnected', () {
    test('should forward the call to DataConnectionChecker.hasConnection WITH true value', () async {
      when(mockDataConnectionChecker.hasConnection).thenAnswer((realInvocation) async => true);
      final result = await networkInfo.isConnected;
      verify(mockDataConnectionChecker.hasConnection);
      expect(result, true);
    });

    test('should forward the call to DataConnectionChecker.hasConnection WITH false value', () async {
      when(mockDataConnectionChecker.hasConnection).thenAnswer((realInvocation) async => false);
      final result = await networkInfo.isConnected;
      verify(mockDataConnectionChecker.hasConnection);
      expect(result, false);
    });
  });
}