import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '09265a2671e0e1c0beb41b2e979def9e';
const openingWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
late NetworkHelper networkHelper;
var weatherData;

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    networkHelper =  NetworkHelper('$openingWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    networkHelper = NetworkHelper(
        '$openingWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
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
