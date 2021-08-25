import 'package:whatsapp/features/authentication/data/models/country_model.dart';

abstract class CountryRemoteDataSource {
  Future<List<CountryModel>> getCountries();
  Future<List<int>> getCountryFlag(String url);
}