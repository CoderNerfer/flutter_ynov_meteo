class Currenthour {
  double lat;
  double lon;
  int timezoneOffset;
  List<Hourly> hourly;

  Currenthour(this.lat, this.lon, this.timezoneOffset, this.hourly);
}

class Hourly {
  int dt;
  double temp;
  List<Weather> weather;

  Hourly(
    this.dt,
    this.temp,
    this.weather,
  );
}

class Weather {
  String icon;
  Weather(this.icon);
}
