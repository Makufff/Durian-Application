import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_1/models/alertdialog.dart';
import 'package:flutter_application_1_1/models/order.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final database = FirebaseDatabase.instance.ref();
  final FirebaseAuth auth = FirebaseAuth.instance;

  List<Color> typeColor = [
    Colors.white,
    Colors.green.shade400,
    Colors.red.shade400
  ];
  List<String> typeName = ['ไม่มีต้นทุเรียน', 'ไม่เป็นโรค', 'เป็นโรค'];
  // List<String> typeName = ['Anthracnose', 'black_mold', 'mold', 'rusty leaves'];
  double? screenWidth;
  dynamic height = 7;
  dynamic width = 5;
  String name = '';
  String text = '';
  List test = [];
  var uid;

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    uid = auth.currentUser!.uid;
    database.child('$uid/name').onValue.listen((event) {
      final getName = event.snapshot.value;
      setState(() {
        name = getName.toString();
      });
    });
    database.child('$uid/text').onValue.listen((event) {
      final getText = event.snapshot.value;
      setState(() {
        text = getText.toString();
      });
    });
    database.child('$uid/text').onValue.listen((event) {
      final getText = event.snapshot.value;
      setState(() {
        text = getText.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 243, 193, 1),
      appBar: AppBar(
        title: const Text('Result'),
        backgroundColor: Colors.green.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/pngegg.png",
                    height: 50,
                  ),
                  info(typeColor[0], typeName[0]),
                  info(typeColor[1], typeName[1]),
                  info(typeColor[2], typeName[2]),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       final nextOrder = <String, dynamic>{
                  //         'description': getRandomDrink(),
                  //         'price': Random().nextInt(3),
                  //         'customer': getRandomName(),
                  //         'time': DateTime.now().microsecondsSinceEpoch
                  //       };
                  //       database
                  //           .child('$uid/orders')
                  //           .push()
                  //           .set(nextOrder)
                  //           .then((_) => print('Drink has been written.'))
                  //           .catchError((error) => print('Error'));
                  //     },
                  //     child: const Text('Append a drink order')),
                  // const SizedBox(
                  //   width: 5,
                  // ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       database.child('$uid/orders').set(null);
                  //     },
                  //     child: const Text('Clear')),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 5),
                child: countColumn(),
              ),
              StreamBuilder(
                  stream: database.child('$uid/orders').orderByKey().onValue,
                  builder: (context, snapshot) {
                    final tilesList = <ElevatedButton>[];
                    if (snapshot.hasData) {
                      final myOrders = Map<String, dynamic>.from(
                          (snapshot.data! as dynamic).snapshot.value);
                      tilesList.addAll(myOrders.values.map((value) {
                        final nextOrder =
                            Order.fromRTDB(Map<String, dynamic>.from(value));
                        Color boxcolor = typeColor[nextOrder.price];
                        return ElevatedButton(
                          // color: boxcolor,
                          style: ElevatedButton.styleFrom(primary: boxcolor),
                          onPressed: () {
                            aboutDialog().resultDialog(
                                context, typeName[nextOrder.price]);
                          },
                          child: Text(
                            nextOrder.timestamp.toString(),
                            style: const TextStyle(color: Colors.transparent),
                          ),
                        );
                      }));
                      tilesList.sort((a, b) =>
                          a.child!.toString().compareTo(b.child!.toString()));
                    }
                    return Expanded(
                      //     child: ListView(
                      //   children: tilesList,
                      // )
                      child: Stack(children: [
                        countRow(),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: GridView.count(
                            crossAxisCount: width,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            children: tilesList,
                          ),
                        ),
                      ]),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
  // GridView getData() {
  //   GridView data = GridView.count(
  //     crossAxisCount: width,
  //     children: [
  //       for (var i = 1; i <= height; i++)
  //         for (var j = 1; j <= width; j++)
  //           Container(
  //             width: 40,
  //             height: 40,
  //             decoration: BoxDecoration(
  //               color: Colors.cyan[(j) * 100],
  //               border: Border.all(color: Colors.black),
  //             ),
  //           ),
  //     ],
  //   );
  //   return data;
  // }

  Row info(Color color, String text) {
    return Row(
      children: [
        Container(
          color: color,
          width: 25,
          height: 25,
        ),
        SizedBox(
          width: 10,
        ),
        Text(text),
      ],
    );
  }

  SizedBox countColumn() {
    return SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (var i = 1; i <= width; i++)
              SizedBox(
                child: Text(
                  i.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              )
          ],
        ));
  }

  SizedBox countRow() {
    return SizedBox(
        width: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 1; i <= 7; i++)
              Container(
                child: Text(
                  i.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                height: (screenWidth! - 20) / (width) - 2,
                alignment: Alignment.center,
              )
          ],
        ));
  }

  String getRandomDrink() {
    final drinkList = [
      'Latte',
      'Cappucino',
      'Macchiato',
      'Cortado',
      'Mocha',
      'Drip coffee',
      'Cold brew',
      'Espresso',
      'Vanilla lattte',
      'Unicorn frappe'
    ];
    return drinkList[Random().nextInt(drinkList.length)];
  }

  String getRandomName() {
    final customerNames = [
      'Sam',
      'Arthur',
      'Jessica',
      'Rachel',
      'Vivian',
      'Todd',
      'Morgan',
      'Perter',
      'David',
      'Sumit'
    ];
    return customerNames[Random().nextInt(customerNames.length)];
  }
}
