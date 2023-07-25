import 'dart:async';

import 'package:api_weather/modules/weather_info.dart';
import 'package:api_weather/screens/location_screen.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State createState() => _LoadingScreentState();
}

class _LoadingScreentState extends State<LoadingScreen> {
  // Location location = Location();

  void getWeatherNow() async {
    try {
      WeatherInfo weatherInfo = WeatherInfo();
      await weatherInfo.getWeatherInfo();
      if (mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LocationScreen(weatherData: weatherInfo);
        }));
      }
    } catch (e) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(40),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.location_off, size: 48, color: Colors.red),
                      Text(
                        "&",
                        style: TextStyle(fontSize: 24),
                      ),
                      Icon(Icons.wifi_off, size: 48, color: Colors.red),
                    ],
                  ),
                ),
                const Text(' - Location service must be active'),
                const SizedBox(
                  height: 8,
                ),
                const Text('- WIFI service must be active'),
                ElevatedButton(
                  onPressed: () {
                    // Action when the first button is pressed
                    Navigator.of(context).pop();
                    Timer(const Duration(seconds: 3), () {
                      getWeatherNow();
                    });
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  void initState() {
    getWeatherNow();
    //getWeatherNow();
    // getWeatherData();
    super.initState();
    // Initialize the state of the widget here.
  }

  @override
  Widget build(BuildContext context) {
    // Build the UI of the widget here.
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App "),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/weather_animated.gif"),
                fit: BoxFit.cover)),
      ),
    );
  }
}
