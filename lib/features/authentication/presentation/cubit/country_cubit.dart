import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp/core/usecases/usecase.dart';
import 'package:whatsapp/features/authentication/domain/entities/country.dart';
import 'package:whatsapp/features/authentication/domain/usecases/get_countries.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  final GetCountries _getCountries;

  CountryCubit(this._getCountries) : super(CountryInitial());

  Future<void> getCountries() async {
    emit(LoadingCountries());

    final failureOrSuccess = await _getCountries(NoParams());
    failureOrSuccess.fold(
      (failure) => emit(CountriesLoadingError()),
      (countries) => emit(CountriesLoaded(countries)),
    );
  }
}
