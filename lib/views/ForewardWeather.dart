import 'package:flutter/material.dart';
import 'package:ynov_meteo/views/NavBar.dart';
import 'package:ynov_meteo/model/weatherdaily.dart';
import 'package:ynov_meteo/services/currentdaily_service.dart';
import 'package:intl/intl.dart';

class ForewardWeather extends StatefulWidget {
  final String title;
  const ForewardWeather({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<ForewardWeather> createState() => _ForewardWeather();
}

class _ForewardWeather extends State<ForewardWeather> {
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
          child: FutureBuilder<List<Currentdaily>>(
              future: getCurrentDailyData(),
              builder: (context, snapshot) {
                if (snapshot.data!.length == 0) {
                  return const Center(child: Text("Chargement impossible ..."));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: Text("Chargement en cours ..."));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat('EEE dd MMM yyyy').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            (snapshot.data![index].daily[0].dt +
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
                                            snapshot.data![index].daily[0]
                                                .weather[0].icon +
                                            ".png"),
                                  ),
                                  Text(
                                    "${(snapshot.data![index].daily[0].temp.day - 273.15).toStringAsFixed(2)}°C",
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
                  );
                }
              }),
        ),
      ),
    );
  }
}
