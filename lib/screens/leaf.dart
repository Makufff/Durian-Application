import 'dart:io';
import 'dart:convert';

import 'package:durain_project_app/screens/diseased.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:durain_project_app/screens/info.dart';

class LeafScreen extends StatefulWidget {
  const LeafScreen({super.key});

  @override
  State<LeafScreen> createState() => _LeafScreenState();
}

class _LeafScreenState extends State<LeafScreen> {
  double screen = 0;

  final picker = ImagePicker();
  bool _loading = true;

  late File _image;
  late Image imgfull;
  List<Map<String, dynamic>> datalist = [];

  ClassifyImage(File imageFile) async {
    _loading = true;
    datalist.clear();
    var url =
        'https://86d2-2001-fb1-182-990a-8043-a9cf-ace6-f59a.ngrok-free.app/predict';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    var file = await http.MultipartFile.fromPath('file', imageFile.path);
    request.files.add(file);
    var responseStream = await request.send();
    var response = await http.Response.fromStream(responseStream);

    var data = jsonDecode(response.body);
    for (var i = 0; i < data.length - 1; i++) {
      datalist.add(data[i]);
    }
    var fullimg_decodedBytes =
        base64Decode(data[data.length - 1]["image"]["body"]);

    setState(() {
      imgfull = Image.memory(fullimg_decodedBytes);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 243, 193, 5),
      appBar: AppBar(
          title: const Text("Leaf"),
          backgroundColor: const Color.fromRGBO(27, 94, 32, 1),
          actions: [
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DiseasedScreen(pageidx: 0, screen: screen)));
              },
            ),
          ]),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text(
                'Disease Detection',
                style: TextStyle(
                    color: Color(0xFF1B5E20),
                    fontWeight: FontWeight.w600,
                    fontSize: 30),
              ),
              const SizedBox(height: 25),
              Center(
                child: _loading
                    ? Container(
                        width: screen * 0.7,
                        height: screen * 0.7,
                        child: Image.asset("assets/icons/Logo.png"),
                      )
                    : Column(
                        children: [
                          Container(
                              width: screen * 0.85,
                              height: screen * 0.85,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    const BoxShadow(
                                        color:
                                            Color.fromARGB(255, 102, 100, 100),
                                        spreadRadius: 1,
                                        blurRadius: 9,
                                        offset: Offset(5, 5)),
                                    const BoxShadow(
                                        color:
                                            Color.fromARGB(255, 210, 211, 163),
                                        spreadRadius: 1,
                                        blurRadius: 8,
                                        offset: Offset(-4, -4))
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                    child: imgfull, fit: BoxFit.contain),
                              )),
                          SizedBox(
                            height: 25,
                          ),
                          datalist.isNotEmpty
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      buildButton('More Info', 'info')
                                    ],
                                  ))
                              : Column(
                                  children: [
                                    Text(
                                      "No disease detected",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                        ],
                      ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      buildButton('Take a Photo', 'camera'),
                      const SizedBox(height: 5),
                      buildButton('Pick from Gallery', 'gallery')
                    ],
                  )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(String text, String cmd) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          if (cmd == 'camera') {
            Camera();
          } else if (cmd == 'gallery') {
            Gallery();
          } else if (cmd == 'info') {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InfoScreen(
                    data: datalist,
                    imgfull: imgfull,
                    screen: screen,
                  ),
                ));
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width - 150,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(53, 112, 64, 1),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 17, color: Colors.white, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  Camera() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    ClassifyImage(_image);
  }

  Gallery() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    ClassifyImage(_image);
  }
}
