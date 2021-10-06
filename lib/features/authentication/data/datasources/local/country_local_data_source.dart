import 'package:whatsapp/features/authentication/data/models/country_model_local.dart';

abstract class CountryLocalDataSource {
  Future<void> storeCountries(List<CountryModelLocal> countries);
  Future<List<dynamic>> getCountries();
}