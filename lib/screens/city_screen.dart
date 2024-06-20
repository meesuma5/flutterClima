import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import '../services/weather.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String city = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.grey.withOpacity(0.8), BlendMode.multiply),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, // Background color
                      shadowColor:
                          Colors.transparent, // Removes shadow/elevation
                      elevation: 0 // Removes the elevation
                      ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: kInputDecoration,
                  onChanged: (value) {
                    city = value;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Text(
                  error,
                  style: TextStyle(
                    color: Color.fromARGB(255, 252, 105, 94),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Spartan MB',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final wm = WeatherModel();
                  String rsp = await wm.validateCity(city);
                  if (rsp == 'City found') {
                    Navigator.pop(context, city);
                  } else {
                    setState(() {
                      error = rsp;
                    });
                  }
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // Background color
                    shadowColor: Colors.transparent, // Removes shadow/elevation
                    elevation: 0 // Removes the elevation
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
