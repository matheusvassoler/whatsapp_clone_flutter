import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp/core/error/exception.dart';
import 'package:whatsapp/features/authentication/data/datasources/remote/country_remote_data_source_impl.dart';
import 'package:whatsapp/features/authentication/data/datasources/uri_requests.dart';
import 'package:whatsapp/features/authentication/data/models/country_model.dart';

import '../../../../../mocks/mock_reader.dart';

class MockDioClient extends Mock implements Dio {}

main() {
  MockDioClient mockDioClient;
  CountryRemoteDataSourceImpl countryRemoteDataSourceImpl;
  
  setUp(() {
    mockDioClient = MockDioClient();
    countryRemoteDataSourceImpl = CountryRemoteDataSourceImpl(client: mockDioClient);
  });
  
  test('SHOULD get countries list WHEN the response code is 200', () async {
    // ARRANGE
    when(mockDioClient.get(any, queryParameters: anyNamed('queryParameters')))
        .thenAnswer((realInvocation) async =>
        Response(data: mock('countries.json'), statusCode: 200, requestOptions: RequestOptions(path: "")));
    final List<dynamic> parsedData = jsonDecode(mock('countries.json'));
    final expectedResult = parsedData.map((e) => CountryModel.fromJson(e)).toList();
    // ACT
    final result = await countryRemoteDataSourceImpl.getCountries();
    // ASSERT
    expect(result, expectedResult);
    verify(mockDioClient.get(UriRequests.countries, queryParameters: {'fields': 'name;translations;nativeName;flag;callingCodes'}));
  });

  test('SHOULD throw ServerException WHEN the response code is different of 200', () async {
    // ARRANGE
    when(mockDioClient.get(any, queryParameters: anyNamed('queryParameters')))
        .thenAnswer((realInvocation) async =>
        Response(data: [], statusCode: 404, requestOptions: RequestOptions(path: "")));
    // ACT
    final call = countryRemoteDataSourceImpl.getCountries;
    // ASSERT
    expect(call(), throwsA(TypeMatcher<ServerException>()));
  });
}