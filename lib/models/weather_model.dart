import 'package:flutter/material.dart';

class WeatherModel {
  String? city;
  String? country;
  double? maxTemp;
  double? minTemp;
  DateTime? time;
  double? temp;
  String? icon;
  String? weatherState;
  List<dynamic>? forecast;

  WeatherModel(
      {required this.city,
      required this.country,
      required this.maxTemp,
      required this.minTemp,
      required this.temp,
      required this.time,
      required this.icon,
      required this.weatherState,
      required this.forecast});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        city: json['location']['name'],
        country: json['location']['country'],
        maxTemp: json['forecast']['forecastday'][0]['day']['maxtemp_c'],
        minTemp: json['forecast']['forecastday'][0]['day']['mintemp_c'],
        temp: json['forecast']['forecastday'][0]['day']['avgtemp_c'],
        time: DateTime.parse(json['current']['last_updated']),
        icon: json['forecast']['forecastday'][0]['day']['condition']['icon'],
        weatherState: json['forecast']['forecastday'][0]['day']['condition']
            ['text'],
        forecast: json['forecast']['forecastday']
        );
  }

  MaterialColor getColor() {
    if (weatherState!.contains('Clear') || weatherState!.contains('Sunny')) {
      return Colors.orange;
    } else if (weatherState!.contains('Sleet') ||
        weatherState!.contains('Snow') ||
        weatherState!.contains('Hail')) {
      return Colors.blue;
    } else if (weatherState!.contains('Cloud') ||
        weatherState!.contains('cloud')) {
      return Colors.blueGrey;
    } else if (weatherState!.contains('Rain') ||
        weatherState!.contains('rain') ||
        weatherState!.contains('Showers')) {
      return Colors.blue;
    } else if (weatherState!.contains('Clear') ||
        weatherState!.contains('Sunny') ||
        weatherState!.contains('Thunder')) {
      return Colors.deepOrange;
    } else {
      return Colors.deepPurple;
    }
  }
}
