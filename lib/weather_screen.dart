import "dart:convert";
import "dart:ui";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "addional_info.dart";
import "hourly_forecast.dart";
import "secrets.dart";
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  @override    
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    String mycity = 'Mumbai';

    try {
      final result = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$mycity&APPID=$weatherAPIkey'));

      final data = jsonDecode(result.body);

      if (data["cod"] != '200') {
        throw 'An error occured ';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Weather App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  
                });
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: FutureBuilder(
            future: getCurrentWeather(),
            builder: ((context, snapshot) {
              // print(snapshot);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 77, 138, 138),
                ));
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }

              //value retrieval from api
              final data = snapshot.data!;
              final newdata = data["list"][0];
              final currentTemp = newdata["main"]["temp"] - 273.15;
              final currentWeather = newdata["weather"][0]["main"];
              final windSpeed = newdata["wind"]["speed"];
              final humidity = newdata["main"]["humidity"];
              final pressure = newdata["main"]["pressure"];

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //main card
                    SizedBox(
                      width: double.infinity,
                      // height: 350,
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        shadowColor: const Color.fromARGB(255, 35, 43, 43),
                        color: Color.fromARGB(255, 46, 70, 70),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Text(
                                    (currentTemp.toStringAsFixed(2)) + '°C',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                  Icon(
                                    currentWeather == 'Rain' ||
                                            currentWeather == 'Clouds'
                                        ? Icons.cloud
                                        : Icons.sunny,
                                    size: 100,
                                  ),
                                  Text(
                                    currentWeather,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Weather Forecast',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),

                    SizedBox(
                      height: 130,
                      child: ListView.builder(
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final hourlytWeather =
                                data["list"][index]["weather"][0]["main"];
                            final hourlyTemp =
                                data["list"][index]["main"]["temp"] -273.15;
                            final hour =
                                DateTime.parse(data["list"][index]["dt_txt"]);

                            return HourlyForecast(
                              data: (hourlyTemp.toStringAsFixed(2)) + '°C',
                              icun: hourlytWeather == 'Rain' ||
                                      hourlytWeather == 'Clouds'
                                  ? Icons.cloud
                                  : Icons.sunny,
                              time: DateFormat.j().format(hour),
                            );
                          }),
                    ),

                    const SizedBox(height: 10),
                    //bottom card
                    const Text(
                      'Additonal Information',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AddInfo(
                            infoOf: 'Humidity',
                            icun: Icons.water_drop,
                            data: '$humidity',
                          ),
                          AddInfo(
                            infoOf: 'Wind Speed',
                            icun: Icons.air,
                            data: windSpeed.toString(),
                          ),
                          AddInfo(
                            infoOf: 'Pressure',
                            icun: Icons.beach_access,
                            data: pressure.toString(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            })));
  }
}
