import 'package:flutter/material.dart';
import 'package:ynov_meteo/views/HomePage.dart';
import 'package:ynov_meteo/views/ForewardWeather.dart';
import 'package:ynov_meteo/views/CitiesManagement.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 32, 32, 32),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 18),
              primary: Colors.white,
            ),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance().then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage(
                          title: value.getString('city_name').toString());
                    },
                  ),
                );
              });
            },
            child: const Text('Meteo Heure par Heure'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 18),
              primary: Colors.white,
            ),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance().then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ForewardWeather(
                          title: value.getString('city_name').toString());
                    },
                  ),
                );
              });
            },
            child: const Text('Prevision Meteo'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 18),
              primary: Colors.white,
            ),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance().then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CitiesManagement(
                          title: value.getString('city_name').toString());
                    },
                  ),
                );
              });
            },
            child: const Text('Gerer vos villes'),
          ),
        ]),
      ),
    );
  }
}
