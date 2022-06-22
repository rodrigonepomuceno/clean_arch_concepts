import 'dart:convert';

import 'package:clean_arc_concepts/data/models/weather_model.dart';
import 'package:clean_arc_concepts/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/json_reader.dart';

void main() {
  const tWeatherModel = WeatherModel(
    cityName: 'Jakarta',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const tWeather = Weather(
    cityName: 'Jakarta',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  group('to entity', () {
    test(
      'should be a subclass of weather entity',
      () async {
        final result = tWeatherModel.toEntity();
        expect(result, equals(tWeather));
      },
    );
  });

  group('from json', () {
    test(
      'should return a valid model from json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          readJson('helpers/dummy_data/dummy_weather_response.json'),
        );

        final result = WeatherModel.fromJson(jsonMap);

        expect(result, equals(tWeatherModel));
      },
    );
  });
  group('to json', () {
    test(
      'should return a json map containing proper data',
      () async {
        // act
        final result = tWeatherModel.toJson();

        // assert
        final expectedJsonMap = {
          'weather': [
            {
              'main': 'Clouds',
              'description': 'few clouds',
              'icon': '02d',
            }
          ],
          'main': {
            'temp': 302.28,
            'pressure': 1009,
            'humidity': 70,
          },
          'name': 'Jakarta',
        };
        expect(result, equals(expectedJsonMap));
      },
    );
  });
}
