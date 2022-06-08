import 'dart:convert';

import 'package:ynov_meteo/model/weatherhour.dart';
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
      Currenthour current = Currenthour(
          double.parse(jsonResponse["lat"].toString()),
          double.parse(jsonResponse["lon"].toString()),
          jsonResponse["timezone_offset"], [
        Hourly(
            jsonResponse["hourly"][i]["dt"],
            double.parse(jsonResponse["hourly"][i]["temp"].toString()),
            [Weather(jsonResponse["hourly"][i]["weather"][0]["icon"])])
      ]);

      currenth.add(current);
    }
  } else {
    print('Request failed : ${responce.statusCode}');
  }
  return currenth;
}
