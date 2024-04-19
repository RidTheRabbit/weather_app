import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/views/home_view.dart';
import 'package:weather_app/views/search_view.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        ],
      child: const WeatherApp()));
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Provider.of<WeatherProvider>(context).weatherData ==
                  null
              ? Colors.purple
              : Provider.of<WeatherProvider>(context).weatherData!.getColor(),
          appBarTheme: AppBarTheme(
            color: Provider.of<WeatherProvider>(context).weatherData ==
                  null
              ? Colors.purple
              : Provider.of<WeatherProvider>(context).weatherData!.getColor(),
          )
              ),
      home: const HomeView(),
      routes: {
        'search': (context) => SearchView(),
      },
    );
  }
}
