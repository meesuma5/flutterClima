import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
  fontWeight: FontWeight.w900,
);
const kHeadingTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 20.0,
  fontWeight: FontWeight.w700,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 57.0,
  fontWeight: FontWeight.w900,
);

const kCardTextStyle = TextStyle(
  fontSize: 20.0,
  fontFamily: 'Spartan MB',
  fontWeight: FontWeight.w600,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
  fontWeight: FontWeight.w900,
);

const kMoreButtonTextStyle = TextStyle(
    fontSize: 15.0,
    fontFamily: 'Spartan MB',
    fontWeight: FontWeight.w700,
    color: Colors.white,
    shadows: [Shadow(color: Colors.black, blurRadius: 100)]);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kInputDecoration = InputDecoration(
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(color: Colors.blueGrey),
);

const apiKey = 'Your openweathermap API Key Here';
const weatherMapUrl = 'https://api.openweathermap.org/data/2.5';
