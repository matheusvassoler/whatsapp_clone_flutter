import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp/core/error/failure.dart';
import 'package:whatsapp/features/authentication/data/datasources/local/country_local_data_source.dart';
import 'package:whatsapp/features/authentication/data/datasources/remote/country_remote_data_source.dart';
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
    try {
      final countries = await countryLocalDataSource.getCountries();
      if (countries.length == 250) {
        return Right(countries);
      } else {
        final countries = await storeCountries();
        Right(countries);
      }
    } catch(e) {
      return Left(InternalFailure());
    }
  }

  Future<List<Country>> storeCountries() async {
    final countries = await countryRemoteDataSource.getCountries();
    final directory = await getApplicationDocumentsDirectory();
    final documentsDirectoryPath = directory.path;
    final countriesList = [];

    countries.forEach((country) async {
      final imagePath = '$documentsDirectoryPath/${countries[0].name}';
      final file = File(imagePath);
      final flag =
          await countryRemoteDataSource.getCountryFlag(countries[0].flag);
      file.writeAsBytes(flag);

      final countryModelLocal = CountryModelLocal(
        translations: country.translations,
        flag: country.flag,
        name: country.name,
        internationalCallingCodes: country.internationalCallingCodes,
        nativeName: country.nativeName,
        path: imagePath,
      );

      countriesList.add(countryModelLocal);
    });

    countryLocalDataSource.storeCountries(countriesList);

    return countriesList;
  }
}
