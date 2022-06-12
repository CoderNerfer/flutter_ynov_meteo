import 'dart:convert';

import 'package:ynov_meteo/model/weatherdaily.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Currentdaily>> getCurrentDailyData() async {
  final prefs = await SharedPreferences.getInstance();
  List<Currentdaily> currentd = [];

  var url = Uri.https("api.openweathermap.org", '/data/2.5/onecall', {
    'lat': prefs.getString('lat'),
    'lon': prefs.getString('lon'),
    'exclude': 'current,minutely,hourly,alerts',
    'appid': '4364afa41febe0e86a2e4b3ae7860fed'
  });
  var responce = await http.get(url);
  if (responce.statusCode == 200) {
    var jsonResponse = jsonDecode(responce.body);
    for (var i = 0; i < jsonResponse["daily"].length - 1; i++) {
      Currentdaily current = Currentdaily(
          double.parse(jsonResponse["lat"].toString()),
          double.parse(jsonResponse["lon"].toString()),
          jsonResponse["timezone_offset"], [
        Daily(
            jsonResponse['daily'][i]['dt'],
            Temp(double.parse(
                jsonResponse['daily'][i]['temp']['day'].toString())),
            [Weather(jsonResponse['daily'][i]['weather'][0]['icon'])])
      ]);
      currentd.add(current);
    }
  } else {
    print('Request failed : ${responce.statusCode}');
    return currentd;
  }
  return currentd;
}
