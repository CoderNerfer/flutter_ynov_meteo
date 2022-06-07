import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ynov_meteo/config.dart';
import 'package:ynov_meteo/model/city.dart';
import 'package:ynov_meteo/cleapi.dart';
import 'package:ynov_meteo/model/climate.dart';

//TODO: Utiliser les fonctions dans bdd.dart pour insérer une nouvelle ville
//      avec les coordonnées
Future<String> fetchCity(city) async {
  final response = await http.get(Uri.parse(
      "http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=1&appid=$apiKey"));
  if (response.statusCode == 200) {
    City city = City.fromJson(jsonDecode(response.body)[0]);
    Climate climate = await fetchWeather(city.lat, city.lon);

    return climate.weather[0].main;
  } else {
    throw Exception('Failed to load city');
  }
}

//TODO: Entrer les valeurs des villes enregistrés
Future<Climate> fetchWeather(lat, lon) async {
  final response = await http.get(Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey"));
  if (response.statusCode == 200) {
    return Climate.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load weather');
  }
}

class Sandbox extends StatefulWidget {
  const Sandbox({Key? key}) : super(key: key);

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  String text = "";
  String text2 = "";
  late Future<City> futureCity;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meteo"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          TextField(
            onChanged: (val) {
              setState(() {
                text = val;
              });
            },
          ),
          const SizedBox(height: 20.0),
          TextButton(
              onPressed: () async {
                text2 = await fetchCity(text);
              },
              child: const Text('Search')),
          const SizedBox(height: 20.0),
          Text(text2)
        ],
      )),
    );
  }
}
