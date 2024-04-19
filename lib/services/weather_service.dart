import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

enum Status {
  loading,
  notLoading,
  finished,
    }
class WeatherService with ChangeNotifier {
  Status loadingStatus = Status.notLoading;
  Future<WeatherModel?> getWeather(String cityName) async {

    String apiKey = '5293b29cf7ca4400b9904457240804';
    String baseURL = 'http://api.weatherapi.com/v1';
    String url = '$baseURL/forecast.json?key=$apiKey&q=$cityName&days=7';

    WeatherModel? weather;
    loadingStatus = Status.loading;
    notifyListeners();
    try {
    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> data = jsonDecode(response.body);
    print('from service: $loadingStatus');

    weather = WeatherModel.fromJson(data);
    
    loadingStatus = Status.notLoading;
    notifyListeners();
    } catch (e) {
      
    loadingStatus = Status.notLoading;
    notifyListeners();
      print(e);
    }
    
    return weather;

  }
}