import 'dart:convert';

import 'package:ynov_meteo/model/weatherdaily.dart';
import 'package:http/http.dart' as http;

Future<List<Currentdaily>> getCurrentDailyData() async {
  List<Currentdaily> currentd = [];

  var url = Uri.https("api.openweathermap.org", '/data/2.5/onecall', {
    'lat': '48.8534',
    'lon': '2.3488',
    'exclude': 'current,minutely,hourly,alerts',
    'appid': '4364afa41febe0e86a2e4b3ae7860fed'
  });
  var responce = await http.get(url);
  if (responce.statusCode == 200) {
    var jsonResponse = jsonDecode(responce.body);
    for (var i = 0; i < jsonResponse["daily"].length - 1; i++) {
      Currentdaily current = Currentdaily(jsonResponse["lat"],
          jsonResponse["lon"], jsonResponse["timezone_offset"], [
        Daily(
            jsonResponse['daily'][i]['dt'],
            Temp(jsonResponse['daily'][i]['temp']['day']),
            [Weather(jsonResponse['daily'][i]['weather'][0]['icon'])])
      ]);
      currentd.add(current);
    }
  } else {
    print('Request failed : ${responce.statusCode}');
  }
  return currentd;
}
