import 'package:flutter/material.dart';
import 'package:ynov_meteo/views/NavBar.dart';
import 'package:ynov_meteo/model/weather.dart';
import 'package:ynov_meteo/services/current_service.dart';
import 'package:ynov_meteo/model/weatherhour.dart';
import 'package:ynov_meteo/services/currenthour_service.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({
    Key? key,
    required this.title,
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
        title: Text(widget.title),
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
                /**
                 * Création d'un widget permetant l'affichage des données météorilogique actuelle
                 * la fonction étant async nous avons un message de chargement ainsi que d'erreur de chargement
                 */
                child: FutureBuilder<Current>(
                  future: getCurrentData(),
                  builder: (context, snapshot) {
                    if (snapshot.data?.timezone == -1) {
                      return const Center(
                          child: Text(
                        "Chargement impossible ...",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                          child: Text(
                        "Chargement en cours ...",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ));
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
                                  Text(
                                    "${DateFormat('EEE dd\nMMM yyyy\nhh:mm a').format(DateTime.fromMillisecondsSinceEpoch((snapshot.data!.dt + (snapshot.data!.timezone)) * 1000))}\n\n${snapshot.data!.weather[0].description}",
                                    style: const TextStyle(
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
                                    "${(snapshot.data!.main.temp - 273.15).toStringAsFixed(2)}°C",
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                /**
                 * Création de widgets permetant l'affichage des données météorilogique heure par heure
                 * la fonction étant async nous avons un message de chargement ainsi que d'erreur de chargement
                 */
                child: FutureBuilder<List<Currenthour>>(
                    future: getCurrentHourData(),
                    builder: (context, snapshot) {
                      if (snapshot.data?.length == 0) {
                        return const Center(
                            child: Text(
                          "Chargement impossible ...",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: Text(
                            "Chargement en cours ...",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 144, 168, 253),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          DateFormat('hh:mm a').format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  (snapshot.data![index]
                                                              .hourly[0].dt +
                                                          (snapshot.data![index]
                                                              .timezoneOffset)) *
                                                      1000)),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Image(
                                          image: NetworkImage(
                                              "http://openweathermap.org/img/wn/" +
                                                  snapshot
                                                      .data![index]
                                                      .hourly[0]
                                                      .weather[0]
                                                      .icon +
                                                  ".png"),
                                        ),
                                        Text(
                                          "${(snapshot.data![index].hourly[0].temp - 273.15).toStringAsFixed(2)}°C",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
