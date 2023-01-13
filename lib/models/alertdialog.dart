import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class alertDialog {
  Future<void> alertLocationService(
      BuildContext context, String title, String message) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: ListTile(
                title: Text(
                  title,
                  style: const TextStyle(fontSize: 18),
                ),
                subtitle: Text(
                  message,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      await Geolocator.openLocationSettings();
                      Navigator.pop(context);
                    },
                    child: const Text('OK'))
              ],
            ));
  }
}

class aboutDialog {
  Future<void> resultDialog(BuildContext context, String result) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: ListTile(
                title: const Text(
                  'ผลลัพธ์',
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text(
                  result.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              actions: [
                TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.green.shade800,
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: const Text('ปิด'))
              ],
            ));
  }

  Future<void> startDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const ListTile(
                title: Text(
                  'เริ่มบินโดรน',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'กรุณานำโดรนไปวางใกล้บริเวณจุดสำรวจ จากนั้นกดปุ่ม "ยืนยัน" เพื่มเริ่มการบินสำรวจโรคใบทุเรียน',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              actions: [
                TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.green.shade800,
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: const Text('ยืนยัน')),
                TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.green.shade800,
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: const Text('ยกเลิก')),
              ],
            ));
  }
}
