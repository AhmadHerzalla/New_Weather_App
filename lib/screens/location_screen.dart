import 'dart:ui';

import 'package:api_weather/component/constants.dart';
import 'package:api_weather/modules/weather_info.dart';
import 'package:api_weather/screens/city_screen.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LocationScreen extends StatefulWidget {
  WeatherInfo weatherData;
  LocationScreen({super.key, required this.weatherData});

  @override
  State createState() => _LocationScreentState();
}

class _LocationScreentState extends State<LocationScreen> {
  late double temp;
  late String cityName;
  late String icon;
  late String descrebtion;

  final ImageProvider _image =
      const AssetImage('images/location_background.jpg');
  final ImageProvider _networkImage =
      const NetworkImage('https://source.unsplash.com/random/?nature,day');
  bool isloaded = false;

  void updateUi() {
    temp = widget.weatherData.temp;
    cityName = widget.weatherData.name;
    icon = widget.weatherData.getWeatherIcon();
    descrebtion = widget.weatherData.getMessage();
  }

  void getBackData() async {
    WeatherInfo weatherInfo = WeatherInfo();
    await weatherInfo.getWeatherInfo();
    setState(() {
      temp = weatherInfo.temp;
      cityName = weatherInfo.name;
      icon = weatherInfo.getWeatherIcon();
      descrebtion = weatherInfo.getMessage();
    });
  }

  void getImageProvider() {
    _networkImage
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((image, synchronousCall) {
      setState(() {
        isloaded = true;
      });
    }));
  }

  @override
  void initState() {
    updateUi();
    getImageProvider();
    super.initState();
    // Initialize the state of the widget here.
  }

  @override
  Widget build(BuildContext context) {
    // Build the UI of the widget here.
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: !isloaded ? _image : _networkImage,
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.25)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: IconButton(
                            onPressed: () {
                              getBackData();
                            },
                            icon: const Icon(
                              Icons.location_on,
                              size: 48,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CityScreen(),
                                  ));
                            },
                            icon: const Icon(
                              Icons.location_city,
                              size: 48,
                            )),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0, top: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          icon,
                          style: const TextStyle(fontSize: 60),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              "${temp.toInt()}",
                              style: kTempTextStyle,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 10),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 7,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                      // shape: BoxShape.circle,
                                      ),
                                ),
                                const Text(
                                  'now',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontFamily: 'Spartan MB',
                                    letterSpacing: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Text(
                      descrebtion,
                      textAlign: TextAlign.right,
                      style: kMessageTextStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0, top: 24),
                    child: Text(
                      cityName,
                      textAlign: TextAlign.right,
                      style: kButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
