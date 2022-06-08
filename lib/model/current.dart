class Current {
  Coord coord;
  List<Weather> weather;
  Main main;
  Wind wind;
  int dt;
  int timezone;

  Current(
    this.coord,
    this.weather,
    this.main,
    this.wind,
    this.dt,
    this.timezone,
  );
}

class Coord {
  double lon;
  double lat;

  Coord(this.lon, this.lat);
}

class Weather {
  String main;
  String description;
  String icon;

  Weather(this.main, this.description, this.icon);
}

class Main {
  double temp;
  int humidity;

  Main(this.temp, this.humidity);
}

class Wind {
  double speed;

  Wind(
    this.speed,
  );
}

class Clouds {
  int all;

  Clouds(this.all);
}

class Sys {
  int type;
  int id;
  String country;
  int sunrise;
  int sunset;

  Sys(this.type, this.id, this.country, this.sunrise, this.sunset);
}
