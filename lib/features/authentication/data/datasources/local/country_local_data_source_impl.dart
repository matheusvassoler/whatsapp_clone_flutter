import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:whatsapp/features/authentication/data/datasources/local/country_local_data_source.dart';
import 'package:whatsapp/features/authentication/data/models/country_model_local.dart';

class CountryLocalDataSourceImpl implements CountryLocalDataSource {
  final HiveInterface hive;

  CountryLocalDataSourceImpl({@required this.hive});

  @override
  Future<void> storeCountries(List<CountryModelLocal> countries) async {
    final countriesBox = await hive.openBox('countries');
    countriesBox.put('countries_list', countries);
  }
}