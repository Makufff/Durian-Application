import 'package:flutter/material.dart';

class DroneScreen extends StatefulWidget {
  const DroneScreen({super.key});

  @override
  State<DroneScreen> createState() => _DroneScreenState();
}

class _DroneScreenState extends State<DroneScreen> {
  double screen = 0;

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 243, 193, 5),
      appBar: AppBar(
        title: const Text("Drone"),
        backgroundColor: const Color.fromRGBO(27, 94, 32, 1),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildLogo("assets/icons/remote.PNG", 0.4),
                const SizedBox(height: 10),
                buildButton('Drone up', 'Manual'),
                const SizedBox(height: 50),
                buildLogo("assets/icons/autopilot.PNG", 0.365),
                const SizedBox(height: 10),
                buildButton('Auto Pilot Drone', 'Auto'),
                const SizedBox(height: 10),
                buildButton('Setup Auto Pilot', 'Setup-Auto'),
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

  Container buildButton(String title, String cmd) {
    return Container(
      width: screen * 0.5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade800,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        onPressed: () {
          if (cmd == 'Manual') {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const ListTile(
                        title: Text(
                          'Drone up',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '\nกรุณานำโดรนไปวางใกล้บริเวณจุดสำรวจ จากนั้นกดปุ่ม "ยืนยัน" เพื่มเริ่มการบินสำรวจโรคใบทุเรียน',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      actions: [
                        TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.green.shade800,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            child: const Text('ยืนยัน')),
                      ],
                    ));
          } else if (cmd == 'Auto') {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const ListTile(
                        title: Text(
                          'Auto-Pilot Drone up',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '\nกรุณานำโดรนไปวางใกล้บริเวณจุดสำรวจ จากนั้นกดปุ่ม "ยืนยัน" เพื่มเริ่มการบินสำรวจโรคใบทุเรียน',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      actions: [
                        TextButton(
                            style: TextButton.styleFrom(
                                primary: Colors.green.shade800,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('ยืนยัน')),
                      ],
                    ));
          } else if (cmd == 'Setup-Auto') {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const ListTile(
                        title: Text(
                          'Auto-Pilot Setup',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '\nสามารถปรับแต่งเส้นทางการบินได้ที่โดรนของท่าน',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      actions: [
                        TextButton(
                            style: TextButton.styleFrom(
                                primary: Colors.green.shade800,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('ยืนยัน')),
                      ],
                    ));
          }
        },
      ),
    );
  }
}
