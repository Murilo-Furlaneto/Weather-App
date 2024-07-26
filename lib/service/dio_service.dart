import 'package:dio/dio.dart';
import 'package:weather_app/service/api_service.dart';

class DioService implements ApiService {
  @override
  Future get() async {
    Dio dio = Dio();
    Response response;

    try {
      response = await dio.get("https://api.hgbrasil.com/weather?key=f401c875&city_name=")
    } catch (e) {
      
    }
  }
}

/*
late Response response;
  Dio dio = Dio();
  Future fetchSearch() async {
    try {
      response = await dio.get(url + input);
      print(response);

      setState(() {
        final Map<dynamic, dynamic> result = response.data;
        location = result["results"]["city"];
        temperature = result["results"]["temp"];
        description = result["results"]["description"];
      });
    } catch (e) {
      print(e);
    }
  }*/