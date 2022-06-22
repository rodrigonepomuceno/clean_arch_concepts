import 'package:clean_arc_concepts/data/datasources/remote_data_source.dart';
import 'package:clean_arc_concepts/data/repositories/weather_repository_impl.dart';
import 'package:clean_arc_concepts/domain/repositories/weather_repository.dart';
import 'package:clean_arc_concepts/domain/usecases/get_currente_weather.dart';
import 'package:clean_arc_concepts/presentation/bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetCurrentWeather(locator()));

  // repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
