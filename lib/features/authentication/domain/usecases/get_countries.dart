import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:whatsapp/core/error/failure.dart';
import 'package:whatsapp/core/usecases/usecase.dart';
import 'package:whatsapp/features/authentication/domain/entities/country.dart';
import 'package:whatsapp/features/authentication/domain/repositories/country_repository.dart';

class GetCountries implements UseCase<List<Country>, NoParams> {
  final CountryRepository countryRepository;

  GetCountries({@required this.countryRepository});

  @override
  Future<Either<Failure, List<Country>>> call(NoParams params) {
    return countryRepository.getCountries();
  }
}