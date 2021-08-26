part of 'country_cubit.dart';

abstract class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object> get props => [];
}

class CountryInitial extends CountryState {}

class LoadingCountries extends CountryState {}

class CountriesLoaded extends CountryState {
  final List<Country> countries;

  CountriesLoaded(this.countries);
}

class CountriesLoadingError extends CountryState {}
