import 'dart:convert';

import 'package:clean_arc_concepts/data/constants.dart';
import 'package:clean_arc_concepts/data/datasources/remote_data_source.dart';
import 'package:clean_arc_concepts/data/exception.dart';
import 'package:clean_arc_concepts/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late RemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RemoteDataSourceImpl(client: mockHttpClient);
  });

  group('Get current weather', () {
    const tCityName = 'Jakarta';
    final tWeatherModel = WeatherModel.fromJson(
      json.decode(
        readJson('helpers/dummy_data/dummy_weather_response.json'),
      ),
    );
    test('Should return weather model when the response code is 200', () async {
      when(
        mockHttpClient.get(
          Uri.parse(Urls.currentWeatherByName(tCityName)),
        ),
      ).thenAnswer(
        (_) async => http.Response(readJson('helpers/dummy_data/dummy_weather_response.json'), 200),
      );
      final result = await dataSource.getCurrentWeather(tCityName);
      expect(result, equals(tWeatherModel));
    });

    test('Should throw a server exception when the response code is 404 or other', () async {
      when(
        mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(tCityName))),
      ).thenAnswer(
        (_) async => http.Response('Not found', 404),
      );
      final call = dataSource.getCurrentWeather(tCityName);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
