import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  int temperature = 22;
  String location = 'São Paulo';
  String description = "";
  String input = "";
  final controller = TextEditingController();
  late String url = "https://api.hgbrasil.com/weather?key=f401c875&city_name=";
  //chave f401c875

  void _setText() {
    setState(() {
      input = controller.text;
      fetchSearch();
    });
  }

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
                        '$temperature°C',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 60.0),
                      ),
                    ),
                    Center(
                      child: Text(
                        location,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 40.0),
                      ),
                    ),
                    Center(
                      child: Text(
                        description,
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
