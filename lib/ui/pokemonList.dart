import 'dart:io';

import 'package:dars37project/models/pokemon.dart';
import 'package:dars37project/ui/pokemonDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonList extends StatefulWidget {
  const PokemonList({Key? key}) : super(key: key);

  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  var dataFromInternetVariable;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataFromInternetVariable = dataFromInternet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon App"),
      ),
//https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json
      body: OrientationBuilder(
        builder: (context, holat) {
          if (holat == Orientation.portrait) {
            return bodyQismiPortrait();
          } else {
            return bodyQismiLandscape();
          }
        },
      ),
    );
  }

  Widget bodyQismiLandscape() {
    return Center(
      child: FutureBuilder(
        future: dataFromInternetVariable,
        builder: (context, AsyncSnapshot snapshot) {
          var data = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Platform.isAndroid
                ? CircularProgressIndicator()
                : CupertinoActivityIndicator();
          } else {
            return GridView.count(
              childAspectRatio: 2,
              crossAxisCount: 3,
              children: data.pokemon.map<Widget>(
                (poke) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return PokemonDetail(
                              kelganPoke: poke,
                              data: data,
                            );
                          },
                        ),
                      );
                    },
                    child: Hero(
                      tag: poke.img,
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 2,
                                offset: Offset(0.5, 0.10),
                              )
                            ],
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.black, width: 0.5)),
                        child: Column(
                          children: [
                            Container(
                              width: 100.0,
                              height: 100.0,
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/loading.gif',
                                image: poke.img != ''
                                    ? poke.img
                                    : 'https://cdn.dribbble.com/users/902865/screenshots/4814970/loading-opaque.gif',
                              ),
                            ),
                            Text(
                              "${poke.name}",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            );
          }
        },
      ),
    );
  }

  Widget bodyQismiPortrait() {
    return Center(
      child: FutureBuilder(
        future: dataFromInternetVariable,
        builder: (context, AsyncSnapshot snapshot) {
          var data = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Platform.isAndroid
                ? CircularProgressIndicator()
                : CupertinoActivityIndicator();
          } else {
            return GridView.count(
              crossAxisCount: 2,
              children: data.pokemon.map<Widget>(
                (poke) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return PokemonDetail(
                              kelganPoke: poke,
                              data: data,
                            );
                          },
                        ),
                      );
                    },
                    child: Hero(
                      tag: poke.img,
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 2,
                                offset: Offset(0.5, 0.10),
                              )
                            ],
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.black, width: 0.5)),
                        child: Column(
                          children: [
                            Container(
                              width: 100.0,
                              height: 100.0,
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/loading.gif',
                                image: poke.img != ''
                                    ? poke.img
                                    : 'https://cdn.dribbble.com/users/902865/screenshots/4814970/loading-opaque.gif',
                              ),
                            ),
                            Text(
                              "${poke.name}",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            );
          }
        },
      ),
    );
  }

  dataFromInternet() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json'));
    if (response.statusCode == 200) {
      return Pokemon.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
