import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_1/models/alertdialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double screen = 0;

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 243, 193, 5),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(27, 94, 32, 1),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(245, 243, 193, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListTile(
              onTap: () async {
                await Firebase.initializeApp().then((value) async {
                  await FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false));
                });
              },
              tileColor: Colors.green.shade900,
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 34,
              ),
              title: const Text("ออกจากระบบ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildLogo("assets/drone.png"),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: screen * 0.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    // primary: Color.fromRGBO(76, 119, 27, 100),
                    backgroundColor: Colors.green.shade800,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text(
                  'เริ่มบินโดรน',
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  aboutDialog().startDialog(context);
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            buildLogo("assets/result.png"),
            const SizedBox(
              height: 50,
            ),
            buildButton("ผลการสำรวจ", '/result'),
            const SizedBox(
              height: 50,
            ),
            buildLogo("assets/leaf.png"),
            const SizedBox(
              height: 50,
            ),
            buildButton("ตรวจสอบใบทุเรียน", '/image'),
          ],
        ),
      ),
    );
  }

  Container buildLogo(String image) {
    return Container(
      width: screen * 0.3,
      child: Image.asset(image),
    );
  }

  Container buildButton(String title, String to_screen) {
    return Container(
      width: screen * 0.5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            // primary: Color.fromRGBO(76, 119, 27, 100),
            primary: Colors.green.shade800,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          title,
          style: TextStyle(fontSize: 15),
        ),
        onPressed: () {
          Navigator.pushNamed(context, to_screen);
        },
      ),
    );
  }
}
