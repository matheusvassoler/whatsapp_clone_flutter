import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:whatsapp/core/error/exception.dart';
import 'package:whatsapp/features/authentication/data/datasources/remote/country_remote_data_source.dart';
import 'package:whatsapp/features/authentication/data/datasources/uri_requests.dart';
import 'package:whatsapp/features/authentication/data/models/country_model.dart';

const _valueForParamFields = 'name;translations;nativeName;flag;callingCodes';
const _responseStatusOk = 200;

class CountryRemoteDataSourceImpl implements CountryRemoteDataSource {
  final Dio client;

  CountryRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<CountryModel>> getCountries() async {
    final response = await client.get(UriRequests.countries, queryParameters: {'fields': _valueForParamFields});
    return getDataIfResponseIsSuccessful(response);
  }

  List<CountryModel> getDataIfResponseIsSuccessful(Response response) {
    if (response.statusCode == _responseStatusOk) {
      final List<dynamic> parsedData = jsonDecode(response.data) as List<dynamic>;
      return parsedData.map((e) => CountryModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }
}