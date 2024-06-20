import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// import '../services/weather.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  void getLocationData() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen();
    }));
  }

  Future<String>? text;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitWaveSpinner(
        color: Colors.white,
        size: 100,
      )
          // Column(
          //   children: [
          //     Padding(
          //       padding:
          //           EdgeInsets.only(top: 100, bottom: 10, left: 10, right: 10),
          //       child: SizedBox(
          //         width: double.infinity,
          //         height: 50,
          //         child: ElevatedButton(
          //           onPressed: () {
          //             //Get the current location
          //             setState(() {
          //               getLocationData();
          //             });
          //           },
          //           child: Text('Get Location'),
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: FutureBuilder(
          //         future: text,
          //         builder: (context, snapshot) {
          //           print(snapshot.data.toString());
          //           if (snapshot.hasData & (snapshot.data.toString() != '')) {
          //             return Text(snapshot.data.toString());
          //           } else {
          //             return Text("Press the button to get location");
          //           }
          //         },
          //       ),
          //     )
          //   ],
          // ),
          ),
    );
  }
}
