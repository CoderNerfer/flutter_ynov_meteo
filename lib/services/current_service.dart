import 'dart:convert';

import 'package:ynov_meteo/model/weather.dart';
import 'package:http/http.dart' as http;

Future<Current> getCurrentData({String city = 'Paris'}) async {
  Current current = Current(
    Coord(0.00, 0.00),
    [Weather("", "", "")],
    Main(0.00, 0),
    Wind(0.00),
    0,
    0,
  );

  var url = Uri.https("api.openweathermap.org", '/data/2.5/weather',
      {'q': city, 'appid': '4364afa41febe0e86a2e4b3ae7860fed'});
  var responce = await http.get(url);
  if (responce.statusCode == 200) {
    var jsonResponse = jsonDecode(responce.body);
    current = Current(
      Coord(double.parse(jsonResponse['coord']['lon'].toString()),
          double.parse(jsonResponse['coord']['lat'].toString())),
      [
        Weather(
            jsonResponse['weather'][0]['main'],
            jsonResponse['weather'][0]['description'],
            jsonResponse['weather'][0]['icon']),
      ],
      Main(double.parse(jsonResponse['main']['temp'].toString()),
          jsonResponse['main']['humidity']),
      Wind(double.parse(jsonResponse['wind']['speed'].toString())),
      jsonResponse['dt'],
      jsonResponse['timezone'],
    );
  } else {
    print('Request failed : ${responce.statusCode}');
  }
  return current;
}
