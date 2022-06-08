class Currenthour {
  double lat;
  double lon;
  //String? timezone;
  int timezoneOffset;
  List<Hourly> hourly;

  Currenthour(this.lat, this.lon, this.timezoneOffset, this.hourly);
}

class Hourly {
  int dt;
  double temp;
  // double? feelsLike;
  // int? pressure;
  // int? humidity;
  // double? dewPoint;
  // double? uvi;
  // int? clouds;
  // int? visibility;
  // double? windSpeed;
  // int? windDeg;
  // double? windGust;
  List<Weather> weather;
  // double? pop;
  // Rain? rain;

  Hourly(
    this.dt,
    this.temp,
    // this.feelsLike,
    // this.pressure,
    // this.humidity,
    // this.dewPoint,
    // this.uvi,
    // this.clouds,
    // this.visibility,
    // this.windSpeed,
    // this.windDeg,
    // this.windGust,
    this.weather,
    // this.pop,
    // this.rain);
  );
}

class Weather {
  // int? id;
  // String? main;
  // String? description;
  String icon;

  Weather(this.icon);
}
