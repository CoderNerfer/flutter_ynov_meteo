import 'dart:convert';

import 'package:ynov_meteo/model/currenthour.dart';
import 'package:http/http.dart' as http;

Future<List<Currenthour>> getCurrentHourData() async {
  List<Currenthour> currenth = [];
  // Currenthour currenth = Currenthour(0.00, 0.00, 0, [
  //   Hourly(0, 0.00, [Weather("")])
  // ]);

  var url = Uri.https("api.openweathermap.org", '/data/2.5/onecall', {
    'lat': '48.8534',
    'lon': '2.3488',
    'exclude': 'current,minutely,daily,alerts',
    'appid': '4364afa41febe0e86a2e4b3ae7860fed'
  });
  var responce = await http.get(url);
  if (responce.statusCode == 200) {
    var jsonResponse = jsonDecode(responce.body);
    for (var i = 0; i < jsonResponse["hourly"].length - 1; i++) {
      Currenthour current = Currenthour(jsonResponse["lat"],
          jsonResponse["lon"], jsonResponse["timezoneOffset"], [
        Hourly(
            jsonResponse["hourly"][i]["dt"],
            jsonResponse["hourly"][i]["temp"],
            [Weather(jsonResponse["hourly"][i]["weather"][0]["icon"])])
      ]);

      currenth.add(current);
    }
  } else {
    print('Request failed : ${responce.statusCode}');
  }
  return currenth;
}