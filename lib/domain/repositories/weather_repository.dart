import 'package:clean_arc_concepts/data/failure.dart';
import 'package:clean_arc_concepts/domain/entities/weather.dart';
import 'package:dartz/dartz.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName);
}
