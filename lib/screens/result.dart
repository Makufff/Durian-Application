import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:durain_project_app/models/map_collection.dart';
import 'package:durain_project_app/models/firebase_collection.dart';
import 'package:durain_project_app/screens/map.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<Widget> widgets = [];

  @override
  void initState() {
    readData();
    super.initState();
  }

  Future<void> readData() async {
    await Firebase.initializeApp().then((value) async {
      CollectionReference mainCollectionRef =
          FirebaseFirestore.instance.collection('diseased');
      QuerySnapshot mainsnapshot =
          await mainCollectionRef.orderBy('date', descending: true).get();

      for (var document in mainsnapshot.docs) {
        Map<String, dynamic>? map = document.data() as Map<String, dynamic>?;
        Collection model = Collection.fromMap(map!);

        CollectionReference subCollectionRef =
            mainCollectionRef.doc(document.id).collection('data');
        QuerySnapshot subSnapshot = await subCollectionRef.get();

        List<mapCollection> listdatamap = [];
        List<String> listid = [];
        for (var mdata in subSnapshot.docs) {
          Map<String, dynamic>? mapdata = mdata.data() as Map<String, dynamic>?;
          mapCollection mapmodel = mapCollection.fromMap(mapdata!);
          listdatamap.add(mapmodel);
          listid.add(mdata.id);
        }

        setState(() {
          widgets.add(CreateWidget(model, listdatamap, listid, context));
        });
      }
    });
  }

  Widget CreateWidget(Collection model, List<mapCollection> listmapmodel,
      List<String> listid, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double level = double.parse(model.description);
    DateTime dateTime = DateFormat('MM/dd/yyyy').parse(model.date);
    String date = DateFormat('d MMMM yyyy').format(dateTime);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
      child: GestureDetector(
        onTap: () {
          if (listmapmodel.length > 0) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MapScreen(data: listmapmodel, date: date, id: listid),
                ));
          }
        },
        child: Center(
          child: Container(
              height: 80,
              width: screenWidth * 0.8,
              decoration: BoxDecoration(
                  color: level == 0
                      ? Colors.green.shade500
                      : level < 5
                          ? Colors.red.shade300
                          : level < 10
                              ? Colors.red.shade400
                              : level < 15
                                  ? Colors.red.shade600
                                  : Colors.red.shade900,
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
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Detect disease spot ${model.description} times",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 216, 216, 216),
                            fontSize: 15),
                      ),
                      Text(
                        "Drone Time : ${model.dronetime}",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 218, 218, 218),
                            fontSize: 13),
                      ),
                    ]),
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 243, 193, 5),
      appBar: AppBar(
        title: const Text("Result"),
        backgroundColor: const Color.fromRGBO(27, 94, 32, 1),
      ),
      body: widgets.length == 0
          ? Container(child: const Center(child: CircularProgressIndicator()))
          : SingleChildScrollView(
              child: Column(children: widgets),
            ),
    );
  }
}
