import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as img;

import 'dart:typed_data';

class TfliteModel extends StatefulWidget {
  TfliteModel({Key? key, required String labels, required String model})
      : super(key: key);

  @override
  _TfliteModelState createState() => _TfliteModelState();
}

class _TfliteModelState extends State<TfliteModel> {
  bool _loading = true;
  late File _image;
  late List _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  ClassifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 5,
      threshold: 0.5,
      imageMean: 175.5,
      imageStd: 175.5,
    );
    setState(() {
      _output = output!;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model.tflite', labels: 'assets/labels.txt');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Tflite.close();
    super.dispose();
  }

  @override
  pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    convertBGRtoRGB(_image);

    resizeImage(_image);

    ClassifyImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    convertBGRtoRGB(_image);

    resizeImage(_image);

    ClassifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(245, 243, 193, 5),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),
              Text(
                'ImageClassification',
                style: TextStyle(color: Color(0xFF1B5E20)),
              ),
              SizedBox(height: 6),
              Text(
                'Disease Detection',
                style: TextStyle(
                    color: Color(0xFF1B5E20),
                    fontWeight: FontWeight.w500,
                    fontSize: 28),
              ),
              SizedBox(height: 40),
              Center(
                child: _loading
                    ? Container(
                        width: 280,
                        child: Column(children: <Widget>[
                          Image.asset('assets/leaf.png'),
                          SizedBox(height: 50),
                        ]),
                      )
                    : Container(
                        child: Column(children: <Widget>[
                          Container(
                            height: 250,
                            child: Image.file(_image),
                          ),
                          SizedBox(height: 20),
                          _output != null
                              ? Text(
                                  '${_output[0]['label']} : ${_output[0]['confidence'].toStringAsFixed(2)}',
                                  style: TextStyle(
                                      color: Color.fromRGBO(27, 94, 32, 1)))
                              : Container(),
                          SizedBox(height: 5),
                        ]),
                      ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 150,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 17),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(27, 94, 32, 1),
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(
                            'Take a photo',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: pickGalleryImage,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 150,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 17),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(27, 94, 32, 1),
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(
                            'Pick form gallery',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }

  void convertBGRtoRGB(File image) async {
    void convertBGRtoRGB(File image) async {
      final codec = await ui.instantiateImageCodec(await image.readAsBytes());
      final frame = await codec.getNextFrame();
      final imageData =
          await frame.image.toByteData(format: ui.ImageByteFormat.png);
      if (imageData != null) {
        final newImage =
            await File(image.path).writeAsBytes(imageData.buffer.asUint8List());
        setState(() {
          _image = newImage;
        });
        ClassifyImage(_image);
      }
    }
  }

  void resizeImage(File image) async {}
}
