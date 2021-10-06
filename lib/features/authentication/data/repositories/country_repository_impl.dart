import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp/core/error/failure.dart';
import 'package:whatsapp/features/authentication/data/datasources/local/country_local_data_source.dart';
import 'package:whatsapp/features/authentication/data/datasources/remote/country_remote_data_source.dart';
import 'package:whatsapp/features/authentication/data/models/country_model.dart';
import 'package:whatsapp/features/authentication/data/models/country_model_local.dart';
import 'package:whatsapp/features/authentication/domain/entities/country.dart';
import 'package:whatsapp/features/authentication/domain/repositories/country_repository.dart';

class CountryRepositoryImpl implements CountryRepository {
  final CountryRemoteDataSource countryRemoteDataSource;
  final CountryLocalDataSource countryLocalDataSource;

  CountryRepositoryImpl(
      {@required this.countryRemoteDataSource,
      @required this.countryLocalDataSource});

  @override
  Future<Either<Failure, List<Country>>> getCountries() async {
    final countries = await countryLocalDataSource.getCountries();
    if (countries != null) {
      if (countries.length == 250) {
        return Right(countries.cast<Country>());
      } else {
        final countries = await storeCountriesLocally();
        return Right(countries);
      }
    } else {
      final countries = await storeCountriesLocally();
      return Right(countries);
    }
  }

  Future<List<Country>> storeCountriesLocally() async {
    final countries = await countryRemoteDataSource.getCountries();
    final List<CountryModelLocal> countriesList = [];

    for (var i = 0; i < countries.length; i++) {
      final flagEmoji = _getCountryEmoji(countries[i].abbreviation);

      final countryModelLocal = CountryModelLocal(
          translations: countries[i].translations,
          flag: countries[i].flag,
          name: countries[i].name,
          internationalCallingCodes: countries[i].internationalCallingCodes,
          nativeName: countries[i].nativeName,
          countryEmoji: flagEmoji,
          abbreviation: countries[i].abbreviation);

      countriesList.add(countryModelLocal);
    }

    countryLocalDataSource.storeCountries(countriesList);

    return countriesList;
  }

  String _getCountryEmoji(String countryAbbreviation) {
    return countryAbbreviation.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0).codeUnitAt(0) + 127397));
  }
}
