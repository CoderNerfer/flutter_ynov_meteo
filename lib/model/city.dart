class City {
  City({
    required this.name,
    required this.localNames,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });
  late final String name;
  late final LocalNames localNames;
  late final double lat;
  late final double lon;
  late final String country;
  late final String state;

  City.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    localNames = LocalNames.fromJson(json['local_names']);
    lat = json['lat'];
    lon = json['lon'];
    country = json['country'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['local_names'] = localNames.toJson();
    _data['lat'] = lat;
    _data['lon'] = lon;
    _data['country'] = country;
    _data['state'] = state;
    return _data;
  }
}

class LocalNames {
  LocalNames();

  LocalNames.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}
