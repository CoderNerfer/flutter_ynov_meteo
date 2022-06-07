import 'package:flutter/material.dart';
import 'package:ynov_meteo/views/NavBar.dart';

class CitiesManagement extends StatefulWidget {
  const CitiesManagement({
    Key? key,
  }) : super(key: key);

  @override
  State<CitiesManagement> createState() => _CitiesManagement();
}

class _CitiesManagement extends State<CitiesManagement> {
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
            child: ListView.builder(
              itemCount: 10,
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
                              "Paris",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.restore_from_trash,
                              color: Color.fromARGB(255, 32, 32, 32),
                              size: 40.0,
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
