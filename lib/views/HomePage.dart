import 'package:flutter/material.dart';
import 'package:ynov_meteo/views/NavBar.dart';
import 'package:ynov_meteo/model/current.dart';
import 'package:ynov_meteo/services/current_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      backgroundColor: const Color.fromARGB(255, 32, 32, 32),
      appBar: AppBar(
        title: const Text('Paris'),
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        toolbarHeight: 50,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(children: [
            Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 20.0),
                child: FutureBuilder<Current>(
                  future: getCurrentData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: Text("Chargement en cours ..."));
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 144, 168, 253),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  const Text(
                                    "Monday\n02, 2022\n21:00",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Image(
                                      image: NetworkImage(
                                          "http://openweathermap.org/img/wn/" +
                                              snapshot.data!.weather[0].icon +
                                              ".png"),
                                    ),
                                  ),
                                ]),
                                Column(children: [
                                  Text(
                                    "${snapshot.data!.main.temp - 273.15}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "Humidite: ${snapshot.data!.main.humidity}%\nVent: ${snapshot.data!.wind.speed}kmh",
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ]),
                              ]),
                        ),
                      );
                    }
                  },
                )
                //
                ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                height: 400,
                child: ListView.builder(
                  itemCount: 24,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 144, 168, 253),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "11:00",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                Image(
                                  image: NetworkImage(
                                      "http://openweathermap.org/img/wn/10d.png"),
                                ),
                                Text(
                                  "12,03°",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
