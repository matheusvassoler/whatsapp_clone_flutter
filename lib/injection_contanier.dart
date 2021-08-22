import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:whatsapp/features/authentication/data/datasources/local/auth_local_data_source.dart';
import 'package:whatsapp/features/authentication/data/datasources/local/auth_local_data_source_impl.dart';
import 'package:whatsapp/features/authentication/data/datasources/remote/auth_remote_data_source.dart';
import 'package:whatsapp/features/authentication/data/datasources/remote/auth_remote_data_source_impl.dart';
import 'package:whatsapp/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:whatsapp/features/authentication/domain/repositories/auth_repository.dart';
import 'package:whatsapp/features/authentication/domain/usecases/sign_in_with_phone_number.dart';
import 'package:whatsapp/features/authentication/domain/usecases/store_contact.dart';
import 'package:whatsapp/features/authentication/domain/usecases/verify_phone_number.dart';
import 'package:whatsapp/features/authentication/presentation/cubit/authentication_cubit.dart';

final getIt = GetIt.instance;

void setupDi() {

  // Cubits
  getIt.registerFactory(() => AuthenticationCubit(getIt()));

  // Use cases
  getIt.registerLazySingleton(() => SignInWithPhoneNumber(getIt()));
  getIt.registerLazySingleton(() => StoreContact(getIt()));
  getIt.registerLazySingleton(() => VerifyPhoneNumber(getIt()));

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: getIt(),
      authLocalDataSource: getIt()
    )
  );

  // Data sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDatSourceImpl(
      auth: getIt(),
      client: getIt()
    )
  );

  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(hive: getIt())
  );
  
  // External
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => Hive);
}