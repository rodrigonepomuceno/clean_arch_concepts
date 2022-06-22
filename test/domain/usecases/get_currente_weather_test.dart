import 'package:clean_arc_concepts/domain/entities/weather.dart';
import 'package:clean_arc_concepts/domain/usecases/get_currente_weather.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetCurrentWeather usecase;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetCurrentWeather(mockWeatherRepository);
  });

  const testWeatherDetail = Weather(
    cityName: 'Jakarta',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const tCityName = 'Jakarta';

  test('Should get current weather detail from the repository', () async {
    when(mockWeatherRepository.getCurrentWeather(tCityName)).thenAnswer(
      (_) async => const Right(testWeatherDetail),
    );
    final result = await usecase.execute(tCityName);

    expect(result, equals(const Right(testWeatherDetail)));
  });
}
