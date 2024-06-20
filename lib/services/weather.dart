import 'package:clima/services/networking.dart';
import 'package:qweather_icons/qweather_icons.dart';

import '../services/location.dart';
import '../utilities/constants.dart';

class WeatherModel {
  Future<Map<String, dynamic>> getCityWeather(String city) async {
    final networkHelper =
        NetworkHelper('$weatherMapUrl/weather?q=$city&appid=$apiKey');
    // text = loc.getCurrentLocation();
    var decodedData = await networkHelper.getData();
    return decodedData;
  }

  bool _isDaytime(DateTime now, int sunriseHour, int sunsetHour, int sunriseMin,
      int sunsetMin) {
    int hour = now.hour;
    int min = now.minute;

    // Example of hardcoded sunrise and sunset times (you would replace with actual data)
    // Example: Replace with actual sunset hour

    // Determine if current hour is between sunrise and sunset
    return hour >= sunriseHour &&
        hour < sunsetHour &&
        min >= sunriseMin &&
        min < sunsetMin;
  }

  Future<dynamic> fetchForecastData(String city) async {
    final networkHelper =
        NetworkHelper('$weatherMapUrl/forecast?q=$city&appid=$apiKey');
    // text = loc.getCurrentLocation();
    var decodedData = await networkHelper.getData();
    return decodedData;
  }

  Future<Map<String, dynamic>> getWeatherData() async {
    final loc = Location();
    await loc.getCurrentLocation();
    final networkHelper = NetworkHelper(
        '$weatherMapUrl/weather?lat=${loc.latitude}&lon=${loc.longitude}&appid=$apiKey');
    // text = loc.getCurrentLocation();
    var decodedData = await networkHelper.getData();
    return decodedData;
  }

// Function to get a suitable weather icon based on weather condition id
  QWeatherIcons getWeatherIcon(int condition, DateTime now, int sunriseHour,
      int sunsetHour, int sunriseMin, int sunsetMin) {
    bool isDay =
        _isDaytime(now, sunriseHour, sunsetHour, sunriseMin, sunsetMin);
    if (condition >= 200 && condition < 300) {
      return QWeatherIcons.tag_heavy_thunderstorm_fill;
    } else if (condition >= 300 && condition < 400) {
      return QWeatherIcons.tag_rain_fill;
    } else if (condition >= 500 && condition < 600) {
      switch (condition) {
        case 500:
          return QWeatherIcons.tag_light_rain_fill;
        case 501:
          return QWeatherIcons.tag_moderate_rain_fill;
        case 502:
        case 503:
        case 504:
          return QWeatherIcons.tag_heavy_rain_fill;
        case 511:
          return QWeatherIcons.tag_sleet_fill;
        case 520:
        case 521:
        case 522:
        case 531:
          return QWeatherIcons.tag_shower_rain_fill;
        default:
          return QWeatherIcons.tag_rain_fill;
      }
    } else if (condition >= 600 && condition < 700) {
      switch (condition) {
        case 600:
        case 601:
          return QWeatherIcons.tag_light_snow_fill;
        case 602:
          return QWeatherIcons.tag_heavy_snow_fill;
        case 611:
        case 612:
        case 613:
          return QWeatherIcons.tag_sleet;
        case 615:
        case 616:
          return QWeatherIcons.tag_rain_and_snow_fill;
        case 620:
        case 621:
        case 622:
          return QWeatherIcons.tag_snow_fill;
        default:
          return QWeatherIcons.tag_snow_fill;
      }
    } else if (condition >= 700 && condition < 800) {
      return QWeatherIcons.tag_foggy_fill;
    } else if (condition == 800) {
      return isDay
          ? QWeatherIcons.tag_sunny_fill
          : QWeatherIcons.tag_clear_night_fill;
    } else if (condition == 801) {
      return isDay
          ? QWeatherIcons.tag_partly_cloudy_fill
          : QWeatherIcons.tag_partly_cloudy_night_fill;
    } else if (condition == 802) {
      return isDay
          ? QWeatherIcons.tag_cloudy_fill
          : QWeatherIcons.tag_cloudy_night_fill;
    } else if (condition == 803 || condition == 804) {
      return QWeatherIcons.tag_overcast_fill;
    } else {
      return QWeatherIcons
          .tag_unknown_fill; // Default icon for unknown conditions
    }
  }

  QWeatherIcons getMWeatherIcon(int condition, isDay) {
    if (condition >= 200 && condition < 300) {
      return QWeatherIcons.tag_heavy_thunderstorm_fill;
    } else if (condition >= 300 && condition < 400) {
      return QWeatherIcons.tag_rain_fill;
    } else if (condition >= 500 && condition < 600) {
      switch (condition) {
        case 500:
          return QWeatherIcons.tag_light_rain_fill;
        case 501:
          return QWeatherIcons.tag_moderate_rain_fill;
        case 502:
        case 503:
        case 504:
          return QWeatherIcons.tag_heavy_rain_fill;
        case 511:
          return QWeatherIcons.tag_sleet_fill;
        case 520:
        case 521:
        case 522:
        case 531:
          return QWeatherIcons.tag_shower_rain_fill;
        default:
          return QWeatherIcons.tag_rain_fill;
      }
    } else if (condition >= 600 && condition < 700) {
      switch (condition) {
        case 600:
        case 601:
          return QWeatherIcons.tag_light_snow_fill;
        case 602:
          return QWeatherIcons.tag_heavy_snow_fill;
        case 611:
        case 612:
        case 613:
          return QWeatherIcons.tag_sleet;
        case 615:
        case 616:
          return QWeatherIcons.tag_rain_and_snow_fill;
        case 620:
        case 621:
        case 622:
          return QWeatherIcons.tag_snow_fill;
        default:
          return QWeatherIcons.tag_snow_fill;
      }
    } else if (condition >= 700 && condition < 800) {
      return QWeatherIcons.tag_foggy_fill;
    } else if (condition == 800) {
      return isDay
          ? QWeatherIcons.tag_sunny_fill
          : QWeatherIcons.tag_clear_night_fill;
    } else if (condition == 801) {
      return isDay
          ? QWeatherIcons.tag_partly_cloudy_fill
          : QWeatherIcons.tag_partly_cloudy_night_fill;
    } else if (condition == 802) {
      return isDay
          ? QWeatherIcons.tag_cloudy_fill
          : QWeatherIcons.tag_cloudy_night_fill;
    } else if (condition == 803 || condition == 804) {
      return QWeatherIcons.tag_overcast_fill;
    } else {
      return QWeatherIcons
          .tag_unknown_fill; // Default icon for unknown conditions
    }
  }

  Future<String> validateCity(String city) async {
    final networkHelper =
        NetworkHelper('$weatherMapUrl/weather?q=$city&appid=$apiKey');
    int response = await networkHelper.getRespCode();

    if (response == 200) {
      // City found
      return 'City found';
    } else if (response == 404) {
      // City not found
      return 'City "$city" not found. Please enter a valid city name.';
    } else {
      // Handle other errors
      return 'Error validating city: ${response}';
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
