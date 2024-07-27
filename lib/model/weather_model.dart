import 'dart:convert';

class WeatherModel {
  final String location;
  final int temperature;
  final String description;

  WeatherModel(
      {required this.location,
      required this.temperature,
      required this.description});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location,
      'temperature': temperature,
      'description': description,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> json) {
    return WeatherModel(
      location: json['location'] as String,
      temperature: (json['temperature'] as num).toInt(),
      description: json['description'] as String,
    );
  }

  factory WeatherModel.fromJsonString(String jsonString) {
    final map = json.decode(jsonString) as Map<String, dynamic>;
    return WeatherModel.fromMap(map);
  }
}
