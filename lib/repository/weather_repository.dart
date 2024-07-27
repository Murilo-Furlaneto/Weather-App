import 'package:weather_app/service/api_service.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/service/erros/failure.dart';

class WeatherRepository {
  final ApiService apiService;

  WeatherRepository(this.apiService);

  Future<WeatherModel> fetchWeather(String location) async {
    try {
      return await apiService.getWeather(location);
    } catch (e) {
      throw Failure('Erro ao buscar clima: $e');
    }
  }
}
