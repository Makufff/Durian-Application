import 'dart:convert';

import 'package:durain_project_app/screens/diseased.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final Image imgfull;
  final double screen;

  const InfoScreen(
      {Key? key,
      required this.data,
      required this.imgfull,
      required this.screen})
      : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  List<Widget> widgetlist = [];

  @override
  void initState() {
    readData();
    super.initState();
  }

  void readData() {
    for (var data in widget.data) {
      var cls = data['class'];
      setState(() {
        if (cls == 'agal spot') {
          cls = 'Agal Spot';
        } else if (cls == 'leftblinght') {
          cls = 'Left Blinght';
        } else if (cls == 'sooty mold') {
          cls = 'Sooty Mold';
        }
        var to_img = base64Decode(data['image']['body']);
        widgetlist.add(CreateWidget(cls, data['conf'], Image.memory(to_img)));
      });
    }
  }

  Widget CreateWidget(String cls, String conf, var img) {
    double screen = widget.screen;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
      child: GestureDetector(
        onTap: () {
          if (cls == 'Anthracnose') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DiseasedScreen(pageidx: 0, screen: screen)));
          } else if (cls == 'Sooty Mold') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DiseasedScreen(pageidx: 1, screen: screen)));
          } else if (cls == 'Agal Spot') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DiseasedScreen(pageidx: 2, screen: screen)));
          } else if (cls == 'Left Blinght') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DiseasedScreen(pageidx: 3, screen: screen)));
          }
        },
        child: Center(
            child: Container(
          height: 80,
          width: screen * 0.8,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                const BoxShadow(
                    color: Color.fromARGB(255, 102, 100, 100),
                    spreadRadius: 1,
                    blurRadius: 9,
                    offset: Offset(5, 5)),
                const BoxShadow(
                    color: Color.fromARGB(255, 210, 211, 163),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: Offset(-4, -4))
              ]),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
                padding: EdgeInsets.only(left: screen * 0.08),
                child: Container(
                  width: 65,
                  height: 65,
                  child: FittedBox(
                    child: img,
                    fit: BoxFit.fill,
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(left: screen * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    cls,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Confidence : ${conf}",
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
            )
          ]),
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screen = widget.screen;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 243, 193, 5),
      appBar: AppBar(
          title: const Text("Leaf Information"),
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
      body: widgetlist.length == 0
          ? Container(child: const Center(child: CircularProgressIndicator()))
          : SingleChildScrollView(
              child: Column(children: [
                Container(
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
                      ],
                    )),
                const SizedBox(height: 20),
                Container(
                    width: screen * 0.85,
                    height: screen * 0.85,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          const BoxShadow(
                              color: Color.fromARGB(255, 102, 100, 100),
                              spreadRadius: 1,
                              blurRadius: 9,
                              offset: Offset(5, 5)),
                          const BoxShadow(
                              color: Color.fromARGB(255, 210, 211, 163),
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: Offset(-4, -4))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: widget.imgfull,
                        fit: BoxFit.contain,
                      ),
                    )),
                const SizedBox(height: 25),
                ...widgetlist,
                const SizedBox(height: 15),
              ]),
            ),
    );
  }
}
