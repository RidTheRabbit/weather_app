import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/services/weather_service.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();

}

class _SearchViewState extends State<SearchView> {
String? cityName;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        WeatherService service = WeatherService();
        WeatherModel? weatherData;
        WeatherModel? weatherDA = Provider.of<WeatherProvider>(context, listen: false).weatherData;
    return ChangeNotifierProvider(
      create: (context) {
        return WeatherService();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
        ),
        body: Center(
          child: Consumer<WeatherService>(
            builder: (context, stateOfLoad, child) {
              return  stateOfLoad.loadingStatus == Status.loading 
              ? const CircularProgressIndicator()
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(borderSide: BorderSide(width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    label: const Text('Search a city'),
                    suffixIcon: IconButton(onPressed: () async{
                      print(stateOfLoad.loadingStatus);
                    service = WeatherService();
                    weatherData = await service.getWeather(cityName!);
                    print(stateOfLoad.loadingStatus);
                    Provider.of<WeatherProvider>(context, listen: false).weatherData = weatherData;
                    Navigator.of(context).pop();
                    }, icon: const Icon(Icons.search))
                  ),
                  onChanged: (value) async {
                    // Navigator.of(context).pushNamed('weatherView');
                    cityName = value;
                  },
                  onSubmitted: (value) async {
                    cityName = value;
                    print(stateOfLoad.loadingStatus);
                    service = WeatherService();
                    weatherData = await service.getWeather(cityName!);
                    print(stateOfLoad.loadingStatus);
                    Provider.of<WeatherProvider>(context, listen: false).weatherData = weatherData;
                    Navigator.of(context).pop();
                  },
                ),
              );
            },          ),
        ),
      ),
    );
  }
}