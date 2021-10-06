import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:whatsapp/features/authentication/data/datasources/local/auth_local_data_source.dart';
import 'package:whatsapp/features/authentication/data/datasources/local/auth_local_data_source_impl.dart';
import 'package:whatsapp/features/authentication/data/datasources/local/country_local_data_source.dart';
import 'package:whatsapp/features/authentication/data/datasources/local/country_local_data_source_impl.dart';
import 'package:whatsapp/features/authentication/data/datasources/remote/auth_remote_data_source.dart';
import 'package:whatsapp/features/authentication/data/datasources/remote/auth_remote_data_source_impl.dart';
import 'package:whatsapp/features/authentication/data/datasources/remote/country_remote_data_source.dart';
import 'package:whatsapp/features/authentication/data/datasources/remote/country_remote_data_source_impl.dart';
import 'package:whatsapp/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:whatsapp/features/authentication/data/repositories/country_repository_impl.dart';
import 'package:whatsapp/features/authentication/domain/repositories/auth_repository.dart';
import 'package:whatsapp/features/authentication/domain/repositories/country_repository.dart';
import 'package:whatsapp/features/authentication/domain/usecases/get_countries.dart';
import 'package:whatsapp/features/authentication/domain/usecases/sign_in_with_phone_number.dart';
import 'package:whatsapp/features/authentication/domain/usecases/store_contact.dart';
import 'package:whatsapp/features/authentication/domain/usecases/verify_phone_number.dart';
import 'package:whatsapp/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:whatsapp/features/authentication/presentation/cubit/country_cubit.dart';

final getIt = GetIt.instance;

void setupDi() {
  // Cubits
  getIt.registerFactory(() => AuthenticationCubit(getIt()));
  getIt.registerFactory(() => CountryCubit(getIt()));

  // Use cases
  getIt.registerLazySingleton(() => SignInWithPhoneNumber(getIt()));
  getIt.registerLazySingleton(() => StoreContact(getIt()));
  getIt.registerLazySingleton(() => VerifyPhoneNumber(getIt()));
  getIt.registerLazySingleton(() => GetCountries(countryRepository: getIt()));

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      authRemoteDataSource: getIt(), authLocalDataSource: getIt()));

  getIt.registerLazySingleton<CountryRepository>(
    () => CountryRepositoryImpl(
      countryRemoteDataSource: getIt(),
      countryLocalDataSource: getIt(),
    ),
  );

  // Data sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDatSourceImpl(
      auth: getIt(),
      client: getIt(),
    ),
  );

  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      hive: getIt(),
    ),
  );

  getIt.registerLazySingleton<CountryLocalDataSource>(
    () => CountryLocalDataSourceImpl(
      hive: getIt(),
    ),
  );

  getIt.registerLazySingleton<CountryRemoteDataSource>(
    () => CountryRemoteDataSourceImpl(
      client: getIt(),
    ),
  );

  // External
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => Hive);
}
