import 'dart:convert';

import 'package:ynov_meteo/model/weather.dart';
import 'package:http/http.dart' as http;

Future<Current> getCurrentData() async {
  Current current = Current(
    Coord(0.00, 0.00),
    [Weather("", "", "")],
    Main(0.00, 0),
    Wind(0.00),
    0,
    0,
  );

  var url = Uri.https("api.openweathermap.org", '/data/2.5/weather',
      {'q': 'Paris', 'appid': '4364afa41febe0e86a2e4b3ae7860fed'});
  var responce = await http.get(url);
  if (responce.statusCode == 200) {
    var jsonResponse = jsonDecode(responce.body);
    current = Current(
      Coord(jsonResponse['coord']['lon'], jsonResponse['coord']['lat']),
      [
        Weather(
            jsonResponse['weather'][0]['main'],
            jsonResponse['weather'][0]['description'],
            jsonResponse['weather'][0]['icon']),
      ],
      Main(jsonResponse['main']['temp'], jsonResponse['main']['humidity']),
      Wind(jsonResponse['wind']['speed']),
      jsonResponse['dt'],
      jsonResponse['timezone'],
    );
  } else {
    print('Request failed : ${responce.statusCode}');
  }
  return current;
}
