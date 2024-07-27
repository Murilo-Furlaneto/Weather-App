import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/service/dio_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String input = "";
  final controller = TextEditingController();
  final WeatherRepository repository = WeatherRepository(DioService(Dio()));
  WeatherModel? weatherModel;

  Future<void> _setText() async {
    setState(() {
      input = controller.text;
    });

    try {
      final fetch = await repository.fetchWeather(input);
      setState(() {
        weatherModel = fetch;
      });
    } catch (e) {
      print('Failed to fetch weather: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/clear.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        weatherModel != null
                            ? weatherModel!.location
                            : 'Informe uma localização',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 40.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        weatherModel != null
                            ? '${weatherModel!.temperature}ºC'
                            : '',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 60.0),
                      ),
                    ),
                    Center(
                      child: Text(
                        weatherModel != null ? weatherModel!.description : '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 40.0),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: controller,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25),
                        decoration: const InputDecoration(
                          hintText: 'Pesquise outra cidade...',
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 18.0),
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  )),
                              onPressed: _setText,
                              child: const Text(
                                'Pesquisar',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
