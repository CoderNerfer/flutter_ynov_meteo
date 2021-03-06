import 'package:flutter/material.dart';
import 'package:ynov_meteo/views/NavBar.dart';
import 'package:ynov_meteo/data/bdd.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CitiesManagement extends StatefulWidget {
  final String title;
  const CitiesManagement({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<CitiesManagement> createState() => _CitiesManagement();
}

class _CitiesManagement extends State<CitiesManagement> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      backgroundColor: const Color.fromARGB(255, 32, 32, 32),
      appBar: AppBar(
        title: Text('Gerer vos villes | actuel ${widget.title}'),
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
                /**
                 * Widget permetant la creation de Widget (ListView servant ?? afficher l'ensemble des villes stocke dans la BDD)
                 * Ces villes contiennent des boutons icons un servant ?? changer la villes du choix et l'autre servant a suprimer la ville de la BDD
                 * La fonction est async, nous allons donc avoir diff??rent message un de chargement un second signalant qu'aucune ville n'est pr??sente dans la BDD 
                 */
                child: FutureBuilder<List<Map>>(
                  future: getCities(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Text(
                          "Chargement en cours ...",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                    if (snapshot.data!.length == 0) {
                      return const Center(
                        child: Text(
                          "Aucune ville renseigner ...",
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
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                final prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                await prefs.setString(
                                                    'lat',
                                                    snapshot.data![index]
                                                        ['latitude']);
                                                await prefs.setString(
                                                    'lon',
                                                    snapshot.data![index]
                                                        ['longitude']);
                                                await prefs.setString(
                                                    'city_name',
                                                    snapshot.data![index]
                                                        ['city']);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return CitiesManagement(
                                                          title: prefs
                                                              .getString(
                                                                  'city_name')
                                                              .toString());
                                                    },
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.add_location_alt,
                                                color: Color.fromARGB(
                                                    255, 32, 32, 32),
                                                size: 40.0,
                                              ),
                                            ),
                                            TextButton(
                                              style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.white),
                                              ),
                                              onPressed: () {
                                                deleteCity(
                                                  snapshot.data![index]['id'],
                                                );
                                                setState(() {});
                                              },
                                              child: const Text('Supprimer'),
                                            )
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
