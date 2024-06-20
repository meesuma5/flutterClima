import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:qweather_icons/qweather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/image.dart' as img;
import '../services/weather.dart';
import './city_screen.dart';
import './moreInfo_screen.dart';
import 'dart:async';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late Future<Map<String, dynamic>> currweatherData;
  String temperature = '';
  int condition = 0;
  QWeatherIcons icont = QWeatherIcons.tag_unknown_fill;
  String cityName = '';
  String message = '';
  String imageURL = '';
  var imageURLList = [];
  late int sunriseHour;
  late int sunsetHour;
  DateTime now = DateTime.now();
  final wm = WeatherModel();
  int high = 0;
  int low = 0;
  int feelsLike = 0;
  bool update = true;
  int count = 0;
  Timer? _timer;
  Timer? _timer2;

  void updateImage() {
    count += 1;
    if (count == imageURLList.length) {
      count = 0;
    }
    setState(() {
      imageURL = imageURLList[count]['urls']['regular'];
    });
  }

  void getWeatherData(var weatherData) async {
    cityName = weatherData['name'];
    imageURLList = await img.fetchCityImage(cityName);
    count = 0;
    // message = await gpt.getWeatherMessage(weatherData);
    setState(() {
      int temp = ((weatherData['main']['temp'] - 273.15).toInt());
      temperature = temp.toString();

      condition = weatherData['weather'][0]['id'];
      sunriseHour = weatherData['sys']['sunrise'];
      sunsetHour = weatherData['sys']['sunset'];
      DateTime sunriseDateTime =
          DateTime.fromMillisecondsSinceEpoch(sunriseHour * 1000, isUtc: true)
              .toLocal();
      DateTime sunsetDateTime =
          DateTime.fromMillisecondsSinceEpoch(sunsetHour * 1000, isUtc: true)
              .toLocal();
      sunriseHour = sunriseDateTime.hour;
      int sunriseMinute = sunriseDateTime.minute;

      sunsetHour = sunsetDateTime.hour;
      int sunsetMinute = sunsetDateTime.minute;
      icont = wm.getWeatherIcon(
          condition, now, sunriseHour, sunsetHour, sunriseMinute, sunsetMinute);
      cityName = weatherData['name'];
      message = wm.getMessage(temp);
      high = (weatherData['main']['temp_max'] - 273.15).toInt();
      low = (weatherData['main']['temp_min'] - 273.15).toInt();
      feelsLike = (weatherData['main']['feels_like'] - 273.15).toInt();

      // message = message;
      imageURL = imageURLList[0]['urls']['regular'];
      print(cityName);
      print(imageURL);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currweatherData = wm.getWeatherData();
    _timer = Timer.periodic(Duration(hours: 1), (timer) {
      currweatherData = wm.getWeatherData();
      update = true;
    });
    _timer2 = Timer.periodic(Duration(seconds: 10), (timer) {
      updateImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
          future: currweatherData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: SpinKitWaveSpinner(
                color: Colors.white,
                size: 100,
              ));
            } else {
              if (update == true) {
                getWeatherData(snapshot.data);
                update = false;
              }
              ;
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageURL.isEmpty
                        ? AssetImage('images/location_background.jpg')
                        : CachedNetworkImageProvider(imageURL) as ImageProvider,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black45.withOpacity(0.6), BlendMode.multiply),
                  ),
                ),
                constraints: BoxConstraints.expand(),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              currweatherData = wm.getWeatherData();
                              update = true;
                            },
                            child: Icon(
                              Icons.near_me,
                              size: 50.0,
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.transparent, // Background color
                                shadowColor: Colors
                                    .transparent, // Removes shadow/elevation
                                elevation: 0 // Removes the elevation
                                ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              var typedCity = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return CityScreen();
                              }));
                              if (typedCity != null) {
                                currweatherData = wm.getCityWeather(typedCity);
                                update = true;
                              }
                            },
                            child: Icon(
                              Icons.location_city,
                              size: 50.0,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.transparent, // Background color
                              shadowColor: Colors
                                  .transparent, // Removes shadow/elevation
                              elevation: 0, // Removes the elevation
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[
                                Text(
                                  '$temperature°',
                                  style: kTempTextStyle,
                                ),
                                Icon(icont.iconData, size: 100),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Feels like: $feelsLike°   H: $high°   L: $low°',
                                  style: kHeadingTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          width: 226.7,
                          height: 60,
                          child: Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(
                                    200, 252, 187, 255), // Background color
                                shadowColor:
                                    Colors.black, // Removes shadow/elevation
                                // elevation: 0, // Removes the elevation
                              ),
                              onPressed: () {
                                if (cityName.isNotEmpty) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MoreInfoScreen(city: cityName),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Upcoming Forecast',
                                style: kMoreButtonTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Text(
                          '$message in $cityName',
                          textAlign: TextAlign.right,
                          style: kMessageTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
