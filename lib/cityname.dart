import 'package:flutter/material.dart';
import 'package:weather_app/weather_screen.dart';

class CityName extends StatefulWidget {
  const CityName({super.key});

  @override
  State<CityName> createState() => _CityNameState();
}

class _CityNameState extends State<CityName> {
  Widget? currScreen;
  var cityName = TextEditingController();
  @override
  void initState() {
    currScreen = Scaffold(
      backgroundColor: const Color.fromARGB(255, 162, 213, 255),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: const Color.fromARGB(255, 0, 26, 48),
        title: const Text(
          'WEATHER APP',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
            // fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter the city name',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              TextField(
                cursorWidth: 2,
                showCursor: true,
                controller: cityName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(strokeAlign: 10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(strokeAlign: 15),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 150,
                child: FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 0, 26, 48),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            WeatherScreen(city: cityName.text),
                      ),
                    );
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return currScreen!;
  }
}
