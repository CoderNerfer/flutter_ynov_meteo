import 'package:flutter/material.dart';
import 'package:ynov_meteo/views/HomePage.dart';
import 'package:ynov_meteo/views/ForewardWeather.dart';
import 'package:ynov_meteo/views/CitiesManagement.dart';

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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const HomePage();
                  },
                ),
              );
            },
            child: const Text('Meteo Heure par Heure'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 18),
              primary: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const ForewardWeather();
                  },
                ),
              );
            },
            child: const Text('Prevision Meteo'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 18),
              primary: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const CitiesManagement();
                  },
                ),
              );
            },
            child: const Text('Gerer vos villes'),
          ),
        ]),
      ),
    );
  }
}
