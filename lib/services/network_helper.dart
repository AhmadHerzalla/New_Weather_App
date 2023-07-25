import 'dart:convert';

import 'package:api_weather/component/constants.dart';
import 'package:api_weather/modules/weather_module.dart';
import 'package:api_weather/services/location_set.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  Future<WeatherModal> getWeatherInLocation() async {
    WeatherModal weatherModa;
    Location location = Location();
    await location.getCurentPostion();
    http.Response respons = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.lat}&lon=${location.lng}&appid=$KApiKey&units=metric'));
    if (respons.statusCode == 200) {
      weatherModa = WeatherModal.fromJson(jsonDecode(respons.body));
      return weatherModa;
    } else {
      return Future.error(
          "error form network class that return curant weather now");
    }
  }

  Future<WeatherModal> getWeatherByName(String cityNameInput) async {
    WeatherModal weatherModal;

    http.Response respons = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityNameInput&appid=$KApiKey&units=metric'));
    if (respons.statusCode == 200) {
      weatherModal = WeatherModal.fromJson(jsonDecode(respons.body));
      return weatherModal;
    } else {
      return Future.error(
          "error form network class that return weathar by name ");
    }
  }
}
