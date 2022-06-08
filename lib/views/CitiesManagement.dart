import 'package:flutter/material.dart';
import 'package:ynov_meteo/views/NavBar.dart';
import 'package:ynov_meteo/data/bdd.dart';

class CitiesManagement extends StatefulWidget {
  const CitiesManagement({
    Key? key,
  }) : super(key: key);

  @override
  State<CitiesManagement> createState() => _CitiesManagement();
}

class _CitiesManagement extends State<CitiesManagement> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      backgroundColor: const Color.fromARGB(255, 32, 32, 32),
      appBar: AppBar(
        title: const Text('Gerer vos villes'),
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        toolbarHeight: 50,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          child: Column(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextField(
                onSubmitted: (value) {
                  createCity(value.toLowerCase()).then((value) {
                    setState(() {});
                  });
                },
                style: const TextStyle(color: Colors.white),
                obscureText: false,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 144, 168, 253),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    labelText: 'Chercher une ville',
                    labelStyle: TextStyle(color: Colors.white)),
              ),
            ]),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: FutureBuilder<List<Map>>(
                  future: getCities(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: Text("Chargement en cours ..."));
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
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
                                          snapshot.data![index]['city'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Row(
                                          children: const [
                                            Icon(
                                              Icons.restore_from_trash,
                                              color: Color.fromARGB(
                                                  255, 32, 32, 32),
                                              size: 40.0,
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                              ),
                            );
                          });
                    }
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
