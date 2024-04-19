import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/widgets/no_weather_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeatherProvider? weatherData = Provider.of<WeatherProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('search');
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: weatherData.weatherData == null
            ? const NoWeatherBody()
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.fast),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    weatherData.weatherData!.getColor(),
                    weatherData.weatherData!.getColor().shade100
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '${weatherData.weatherData!.city}',
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${weatherData.weatherData!.country}',
                            style: const TextStyle(fontSize: 23),
                          ),
                          Text(
                            'Updated: ${weatherData.weatherData!.time!.hour}:${weatherData.weatherData!.time!.minute}',
                            style: const TextStyle(fontSize: 21),
                          )
                        ],
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.network(
                            'http:${weatherData.weatherData!.icon}',
                            scale: 0.8,
                          ),
                          Text(
                            '${weatherData.weatherData!.maxTemp}',
                            style: const TextStyle(fontSize: 28),
                          ),
                          Column(
                            children: [
                              Text(
                                'Max temp: ${weatherData.weatherData!.maxTemp}',
                                style: const TextStyle(fontSize: 22),
                              ),
                              Text(
                                'Min temp: ${weatherData.weatherData!.minTemp}',
                                style: const TextStyle(fontSize: 22),
                              ),
                            ],
                          )
                        ],
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Text(
                        '${weatherData.weatherData!.weatherState}',
                        style: const TextStyle(
                            fontSize: 27, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Text(
                              'Forecast:',
                              style: TextStyle(fontSize: 23),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Card(
                        color: weatherData.weatherData!.getColor().shade100,
                        child: Container(
                          height: 250,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(10)),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 20,
                                    mainAxisExtent: 120),
                            itemCount:
                                weatherData.weatherData!.forecast!.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                          '${DateTime.parse(weatherData.weatherData!.forecast![index]['date']).day}-${DateTime.parse(weatherData.weatherData!.forecast![index]['date']).month}'),
                                      Image.network(
                                          'http:${weatherData.weatherData!.forecast![index]['day']['condition']['icon']}'),
                                      Text(
                                          '${weatherData.weatherData!.forecast![index]['day']['avgtemp_c']} C')
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ),
              ));
  }
}
