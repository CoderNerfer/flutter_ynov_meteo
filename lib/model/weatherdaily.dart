class Currentdaily {
  double lat;
  double lon;
  int timezoneOffset;
  List<Daily> daily;

  Currentdaily(this.lat, this.lon, this.timezoneOffset, this.daily);
}

class Daily {
  int dt;
  Temp temp;
  List<Weather> weather;

  Daily(
    this.dt,
    this.temp,
    this.weather,
  );
}

class Temp {
  double day;
  Temp(this.day);
}

class Weather {
  String icon;
  Weather(this.icon);
}
