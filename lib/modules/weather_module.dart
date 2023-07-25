// To parse this JSON data, do
//
//     final weatherModa = weatherModaFromJson(jsonString);

import 'dart:convert';

WeatherModal weatherModaFromJson(String str) =>
    WeatherModal.fromJson(json.decode(str));

String weatherModaToJson(WeatherModal data) => json.encode(data.toJson());

class WeatherModal {
  Coord coord;
  List<Weather> weather;
  String base;
  Main main;
  int id;
  String name;

  WeatherModal({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.id,
    required this.name,
  });

  factory WeatherModal.fromJson(Map<String, dynamic> json) => WeatherModal(
        coord: Coord.fromJson(json["coord"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        base: json["base"],
        main: Main.fromJson(json["main"]),
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "coord": coord.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "base": base,
        "main": main.toJson(),
        "id": id,
        "name": name,
      };
}

class Coord {
  double lon;
  double lat;

  Coord({
    required this.lon,
    required this.lat,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json["lon"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
      };
}

class Main {
  double temp;

  Main({
    required this.temp,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
      };
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}
