import 'package:durain_project_app/screens/diseased.dart';
import 'package:flutter/material.dart';

import 'drone.dart';
import 'leaf.dart';
import 'result.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double screen = 0;

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 243, 193, 5),
      appBar: AppBar(
          title: const Text("Durian"),
          backgroundColor: const Color.fromRGBO(27, 94, 32, 1),
          actions: [
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DiseasedScreen(pageidx: 0, screen: screen)));
              },
            ),
          ]),
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(245, 243, 193, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListTile(
              tileColor: Colors.green.shade900,
              leading: Image.asset(
                'assets/icons/Logo.png',
                width: 34,
                height: 34,
                color: Colors.white,
              ),
              title: const Text("Durian App",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildLogo("assets/icons/drone.png", 0.32),
                const SizedBox(height: 10),
                buildButton("Drone"),
                const SizedBox(height: 32),
                buildLogo("assets/icons/result.png", 0.32),
                const SizedBox(height: 10),
                buildButton("Result"),
                const SizedBox(height: 32),
                buildLogo("assets/icons/check.PNG", 0.29),
                const SizedBox(height: 12),
                buildButton("Leaf"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildLogo(String image, double size) {
    return Container(
      width: screen * size,
      child: Image.asset(image),
    );
  }

  Container buildButton(String title) {
    return Container(
      width: screen * 0.6,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade800,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        onPressed: () {
          if (title == 'Drone') {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DroneScreen(),
                ));
          } else if (title == 'Result') {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResultScreen(),
                ));
          } else if (title == 'Leaf') {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LeafScreen(),
                ));
          }
        },
      ),
    );
  }
}
