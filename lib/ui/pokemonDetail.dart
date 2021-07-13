import 'package:dars37project/models/pokemon.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class PokemonDetail extends StatelessWidget {
  var kelganPoke;
  var data;
  Pokemon? pokemon;
  PokemonDetail({this.kelganPoke, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        title: Text(kelganPoke.name.toString()),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return stackWidgetPortrait(context);
          } else {
            return stackWidgetLandscape(context);
          }
        },
      ),
    );
  }

  Widget stackWidgetLandscape(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          width: MediaQuery.of(context).size.width - 40,
          height: MediaQuery.of(context).size.height - 100,
          top: 20,
          right: 20,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 1,
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Hero(
            tag: kelganPoke.img,
            child: Image.network(
              kelganPoke.img,
              fit: BoxFit.contain,
              width: 250.0,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "${kelganPoke.candy} Landscape",
                style: TextStyle(
                    fontSize: 25.0,
                    backgroundColor: Colors.grey.withOpacity(0.2)),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: chiplar(),
            ),
            SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                height: 90.0,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    int son = a();
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(data.pokemon[son].img)),
                            ),
                          ),
                        ),
                        Positioned(
                          child: Text("${data.pokemon[son].name}"),
                          bottom: 10,
                        ),
                      ],
                    );
                  },
                  itemCount: 14,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: EdgeInsets.all(40.0),
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: kelganPoke.nextEvolution != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 38.0),
                    child: Column(
                      children: [
                        Text("Next Level"),
                        Text("${kelganPoke.nextEvolution[0].nameLevel}"),
                      ],
                    ),
                  )
                : Text("There is no Next Evolution"),
          ),
        ),
      ],
    );
  }

  Widget stackWidgetPortrait(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          width: MediaQuery.of(context).size.width - 40,
          height: MediaQuery.of(context).size.height - 300,
          top: 20,
          right: 20,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 1,
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: kelganPoke.img,
            child: Image.network(
              kelganPoke.img,
              fit: BoxFit.contain,
              width: 200.0,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "${kelganPoke.candy}",
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: chiplar(),
            ),
            kelganPoke.nextEvolution != null
                ? Padding(
                    padding: const EdgeInsets.all(38.0),
                    child: ListTile(
                      trailing: Icon(Icons.arrow_forward),
                      title: Text("Next Level"),
                      subtitle:
                          Text("${kelganPoke.nextEvolution[0].nameLevel}"),
                    ),
                  )
                : Text("There is no Next Evolution"),
            Padding(
              padding: const EdgeInsets.only(top: 48.0),
              child: Container(
                height: 100.0,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    int son = a();
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(data.pokemon[son].img)),
                            ),
                          ),
                        ),
                        Positioned(
                          child: Text("${data.pokemon[son].name}"),
                          bottom: 0,
                        ),
                      ],
                    );
                  },
                  itemCount: 7,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> chiplar() {
    List<Widget> list = [];
    for (var i = 0; i < kelganPoke.weaknesses.length; i++) {
      list.add(Chip(
        backgroundColor: Colors.amberAccent,
        label: Text("${kelganPoke.weaknesses[i]}"),
      ));
    }
    return list;
  }

  a() {
    // data.pokemon[index].name
    int son = Random().nextInt(100);
    return son;
  }
}
