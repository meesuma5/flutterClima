import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:qweather_icons/qweather_icons.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/string_format.dart';
import '../services/weather.dart';

class MoreInfoScreen extends StatefulWidget {
  final String city;

  MoreInfoScreen({required this.city});

  @override
  _MoreInfoScreenState createState() => _MoreInfoScreenState();
}

class _MoreInfoScreenState extends State<MoreInfoScreen> {
  late Future<dynamic> forecastData;

  final wm = WeatherModel();
  @override
  void initState() {
    super.initState();
    forecastData = wm.fetchForecastData(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upcoming Forecast',
          style: kHeadingTextStyle,
        ),
      ),
      body: FutureBuilder<dynamic>(
        future: forecastData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: SpinKitWaveSpinner(
              color: Colors.white,
              size: 100,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data['list'].length,
              itemBuilder: (context, index) {
                var forecast = snapshot.data['list'][index];
                var dateTime =
                    DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000);
                int temp = (forecast['main']['temp'] - 273.15).toInt();
                var description = forecast['weather'][0]['description'];
                // var iconCode = forecast['weather'][0]['icon'];
                var weatherId = forecast['weather'][0]['id'];
                bool isDay = forecast['sys']['pod'] == 'd';
                // var iconUrl = 'http://openweathermap.org/img/wn/$iconCode.png';
                QWeatherIcons icon = wm.getMWeatherIcon(weatherId, isDay);
                return ListTile(
                  leading: Icon(icon.iconData, size: 30),
                  title: Text(
                    capitalizeFirstLetterOfEachWord('$description'),
                    style: kCardTextStyle,
                  ),
                  subtitle: Text(
                      '${dateTime.day} ${getMonth(dateTime.month)},${dateTime.year} ${convert24To12Hour(DateFormat.Hm().format(dateTime))}'),
                  trailing: Text(
                    '${temp}°C',
                    style: kCardTextStyle,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
