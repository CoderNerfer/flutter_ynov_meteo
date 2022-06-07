import 'package:flutter/material.dart';
import 'package:ynov_meteo/views/NavBar.dart';

class ForewardWeather extends StatefulWidget {
  const ForewardWeather({
    Key? key,
  }) : super(key: key);

  @override
  State<ForewardWeather> createState() => _ForewardWeather();
}

class _ForewardWeather extends State<ForewardWeather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      backgroundColor: const Color.fromARGB(255, 32, 32, 32),
      appBar: AppBar(
        title: const Text('Paris'),
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        toolbarHeight: 50,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Container(
            // height: 400,
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
                          children: [
                            const Text(
                              "Tuesday, 07 June 2022",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              color: Colors.black,
                            ),
                            // Image(
                            //   image: NetworkImage(
                            //       "http://openweathermap.org/img/wn/10d.png"),
                            // )
                            const Text(
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
      ),
    );
  }
}
