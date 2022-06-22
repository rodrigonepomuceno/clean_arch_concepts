import 'package:clean_arc_concepts/data/failure.dart';
import 'package:clean_arc_concepts/domain/entities/weather.dart';
import 'package:clean_arc_concepts/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentWeather {
  final WeatherRepository repository;

  GetCurrentWeather(this.repository);

  Future<Either<Failure, Weather>> execute(String cityName) {
    return repository.getCurrentWeather(cityName);
  }
}
