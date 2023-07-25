import 'package:api_weather/modules/weather_info.dart';
import 'package:api_weather/screens/location_screen.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State createState() => _CityScreentState();
}

class _CityScreentState extends State<CityScreen> {
  String? cityNameInputl = "Indonesia";
  void getWeatherData(String name) async {
    WeatherInfo weatherInfo = WeatherInfo();
    await weatherInfo.getWeatherInfoByName(name);
    if (mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(weatherData: weatherInfo);
      }));
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize the state of the widget here.
  }

  @override
  Widget build(BuildContext context) {
    // Build the UI of the widget here.
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "images/city_location.jpg",
                ),
                fit: BoxFit.fill)),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 40.0,
                  ),
                ),
              ),
              const Text(
                "Enter the name of the city you want",
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Spartan MB',
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              CountryListPick(

                  // if you need custome picker use this
                  // pickerBuilder: (context, CountryCode countryCode){
                  //   return Row(
                  //     children: [
                  //       Image.asset(
                  //         countryCode.flagUri,
                  //         package: 'country_list_pick',
                  //       ),
                  //       Text(countryCode.code),
                  //       Text(countryCode.dialCode),
                  //     ],
                  //   );
                  // },

                  // To disable option set to false
                  theme: CountryTheme(
                    isShowFlag: true,
                    isShowTitle: true,
                    isShowCode: true,
                    isDownIcon: true,
                    showEnglishName: true,
                  ),
                  // Set default value
                  initialSelection: '+62',

                  // or
                  // initialSelection: 'US'
                  onChanged: (CountryCode? code) {
                    cityNameInputl = code!.name;
                    // print(code.code);
                    // print(code.dialCode);
                    // print(code.flagUri);
                  },
                  // Whether to allow the widget to set a custom UI overlay
                  useUiOverlay: true,
                  // Whether the country list should be wrapped in a SafeArea
                  useSafeArea: true),
              // TextField(
              //   style: const TextStyle(
              //     color: Colors.white,
              //     fontSize: 30.0,
              //     fontFamily: 'Spartan MB',
              //   ),
              //   onChanged: (value) {
              //     cityNameInput = value;
              //     //print(cityNameInput);
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 330.0),
                child: TextButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blue),
                      overlayColor: MaterialStatePropertyAll(Colors.blueGrey)),
                  onPressed: () {
                    getWeatherData(cityNameInputl!);
                  },
                  child: const Text(
                    'Get Weather',
                    style: TextStyle(color: Colors.white, fontSize: 32),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
