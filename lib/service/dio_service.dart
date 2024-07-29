import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather_app/key.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/service/api_service.dart';
import 'package:weather_app/service/erros/failure.dart';

class DioService implements ApiService {
  final Dio dio;

  DioService(this.dio);

  @override
  Future<WeatherModel> getWeather(String location) async {
    Response response;

    try {
      response = await dio
          .get("https://api.hgbrasil.com/weather?key=$KEY&city_name=$location");
      final Map<dynamic, dynamic> result = response.data;

      if (response.statusCode == 200) {
        print(response.data);

        final Map<String, dynamic> map = response.data;

        return WeatherModel(
            location: result["results"]["city"],
            temperature: result["results"]["temp"],
            description: result["results"]["description"]);
      } else {
        throw Failure('Erro: Status code ${response.statusCode}');
      }
    } on HttpException {
      throw Failure('Erro na requisição: Post não encontrado');
    } on FormatException {
      throw Failure('Formato de requisição incorreto');
    } catch (e) {
      throw Failure('Erro desconhecido: $e');
    }
  }
}
