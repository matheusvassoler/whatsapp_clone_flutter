

//Service location
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/features/inbox_message/data/datasources/inbox_local_data_source.dart';
import 'package:whatsapp/features/inbox_message/data/datasources/inbox_remote_data_source.dart';

import 'core/network/network_info.dart';
import 'features/inbox_message/data/repositories/inbox_repository_impl.dart';
import 'features/inbox_message/domain/repositories/inbox_repository.dart';
import 'features/inbox_message/domain/usecases/get_inboxes.dart';
import 'features/inbox_message/presentation/bloc/inboxes_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Inbox
  sl.registerFactory(() => InboxesBloc(getInboxes: sl()));
  sl.registerSingleton(() => GetInboxes(sl()));

  // Repository
  sl.registerSingleton<InboxRepository>(() => InboxRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<InboxRemoteDataSource>(() => InboxRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<InboxLocalDataSource>(() => InboxLocalDataSourceImpl(sharedPreferences: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() async => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => DataConnectionChecker());
}