import 'package:dartz/dartz.dart';
import 'package:whatsapp/core/error/failure.dart';
import 'package:whatsapp/features/authentication/domain/entities/country.dart';

abstract class CountryRepository {
  Future<Either<Failure, List<Country>>> getCountries();
}