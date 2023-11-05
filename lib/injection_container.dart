import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/random_remote_data_source.dart';
import 'data/datasources/word_remote_data_sources.dart';
import 'data/repositories/random_repository_impl.dart';
import 'data/repositories/word_repository_impl.dart';
import 'domain/repositories/random_repository.dart';
import 'domain/repositories/word_repository.dart';
import 'domain/usecases/get_def_usecase.dart';
import 'domain/usecases/random_usecase.dart';
import 'presentation/random_bloc/random_bloc.dart';
import 'presentation/word_bloc/word_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  // bloc
  locator.registerFactory(() => WordBloc(locator()));
  locator.registerFactory(() => RandomBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetDefUseCase(locator()));
  locator
      .registerLazySingleton(() => RandomUseCase(randomRepository: locator()));

  // repository
  locator.registerLazySingleton<WordRepository>(
    () => WordRepositoryImpl(wordRemoteDataSource: locator()),
  );
  locator.registerLazySingleton<RandomRepository>(
    () => RandomRepositoryImpl(randomRemoteDataSource: locator()),
  );

  // data source
  locator.registerLazySingleton<WordRemoteDataSource>(
    () => WordRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<RandomRemoteDataSource>(
    () => RandomRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
