import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DroneScreen extends StatefulWidget {
  const DroneScreen({Key? key}) : super(key: key);

  @override
  _DroneScreenState createState() => _DroneScreenState();
}

class _DroneScreenState extends State<DroneScreen> {
  final database = FirebaseDatabase.instance.ref();

  dynamic length;
  dynamic wide;
  String _name = '';

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    database.child('text_drone').onValue.listen((event) {
      final String name = event.snapshot.value.toString();
      setState(() {
        _name = name;
      });
    });
    database.child('size/length').onValue.listen((event) {
      length = event.snapshot.value;
    });
    database.child('size/wide').onValue.listen((event) {
      wide = event.snapshot.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 243, 193, 1),
      appBar: AppBar(
        title: const Text('Drone'),
        backgroundColor: Colors.green.shade900,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'กำหนดวันบินโดรน',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'รูปแบบที่ 1',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          width: 20,
                          height: 30,
                        ),
                        Text(
                          'เริ่มวันที่ ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          width: 20,
                          height: 30,
                        ),
                        Text(
                          'บินทุก ๆ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
