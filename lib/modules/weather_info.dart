import 'package:api_weather/modules/weather_module.dart';
import 'package:api_weather/services/network_helper.dart';

class WeatherInfo {
  late double temp;
  late int weatharId;
  late String name;

  Future<void> getWeatherInfo() async {
    NetworkHelper networkHelper = NetworkHelper();
    WeatherModal data = await networkHelper.getWeatherInLocation();
    temp = data.main.temp;
    weatharId = data.weather[0].id;
    name = data.name;
  }

  Future<void> getWeatherInfoByName(String cityNameInput) async {
    NetworkHelper networkHelper = NetworkHelper();
    WeatherModal data = await networkHelper.getWeatherByName(cityNameInput);
    temp = data.main.temp;
    weatharId = data.weather[0].id;
    name = data.name;
  }

  String getWeatherIcon() {
    if (weatharId < 300) {
      return '🌩';
    } else if (weatharId < 400) {
      return '🌧';
    } else if (weatharId < 600) {
      return '☔️';
    } else if (weatharId < 700) {
      return '☃️';
    } else if (weatharId < 800) {
      return '🌫';
    } else if (weatharId == 800) {
      return '☀️';
    } else if (weatharId <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage() {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
