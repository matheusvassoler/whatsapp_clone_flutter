import 'package:whatsapp/features/authentication/data/models/country_model.dart';

abstract class CountryRemoteDataSource {
  Future<List<dynamic>> getCountries();
  Future<List<int>> getCountryFlag(String url);
}