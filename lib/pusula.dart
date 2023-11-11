import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(KiblahFinderApp());
}

class KiblahFinderApp extends StatefulWidget {
  @override
  _KiblahFinderAppState createState() => _KiblahFinderAppState();
}

class _KiblahFinderAppState extends State<KiblahFinderApp> {
   double kiblahDirection = 0; // Kıble yönü

  @override
  void initState() {
    super.initState();
    _getKiblahDirection();
  }

  Future<void> _getKiblahDirection() async {
    // Kullanıcının konum izni kontrolü
    final LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Konum izni yoksa kullanıcıdan izin talep et
      final LocationPermission newPermission = await Geolocator.requestPermission();
      if (newPermission == LocationPermission.denied) {
        // Kullanıcı izin vermedi, işlemlerinizi uygun şekilde ele alın
      }
    }

    // Kullanıcının mevcut konumunu alın
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // Kıble yönünü hesaplayın
    double latitude = position.latitude;
    double longitude = position.longitude;
    double kiblahLatitude = 21.422513; // Mekke'nin enlemi
    double kiblahLongitude = 39.825919; // Mekke'nin boylamı

    double deltaLongitude = kiblahLongitude - longitude;

    double y = sin(deltaLongitude);
    double x = cos(latitude) * tan(kiblahLatitude) - sin(latitude) * cos(deltaLongitude);
    kiblahDirection = atan2(y, x);

    // Radyan cinsinden hesaplanan değeri dereceye çevirin
    kiblahDirection = kiblahDirection * 180 / pi;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kıble Bulucu'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/konum.gif",height: 200,width: 355,),
              const SizedBox(height: 33,width: 23,),
              Text(
                'Kıble Yönü: ${kiblahDirection.toStringAsFixed(2)} derece',
                style: TextStyle(fontSize: 24.0),
              ),
              const SizedBox(height: 20.0),
              Transform.rotate(
                angle: pi / 180 * kiblahDirection,
                child: const Icon(
                  Icons.navigation,
                  size: 100.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
