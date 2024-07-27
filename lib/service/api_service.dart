import 'package:weather_app/model/weather_model.dart';

abstract class ApiService {
  Future<WeatherModel> getWeather(String location);
}
