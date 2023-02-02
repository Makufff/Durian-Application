import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';

class TfliteModel extends StatefulWidget {
  const TfliteModel({
    Key? key,
  }) : super(key: key);

  @override
  _TfliteModelState createState() => _TfliteModelState();
}

class _TfliteModelState extends State<TfliteModel> {
  bool _loading = true;
  late File _image;
  late Map<String, dynamic> _output;
  final picker = ImagePicker();

  // label
  var discriptions_1 = [
    "สาเหตุ : เกิดจาก สาหร่าย Cephaleuros virescens Kunze",
    "สาเหตุ : เกิดจากเชื้อรา Colletotrichum zibethinum Sacc.",
    "สาเหตุ : เกิดจากเชื้อรา Phomopsis sp. ",
    "ปกติดี",
    "สาเหตุ : เกิดจากเชื้อรา Capnodium sp. Mont. ",
  ];
  var discriptions_2 = [
    "การแพร่กระจายของโรค : แพร่ระบาดไปกับลมและพายุฝน เข้าทำลายในสภาพอากาศที่มีความชื้นสูง นอกจากนี้ น้ำก็เป็นพาหะนำสปอร์ไปสู่ต้นอื่นได้เช่นเดียวกัน",
    "การแพร่กระจายของโรค : ลมและฝนพัดพาโรคจากใบและกิ่งสู่ดอก",
    "การแพร่กระจายของโรค : จะแพร่ระบาดไปโดยลม และ ฝน และ จากเนื้อเยื่อใบที่แห้งและหล่นตกคางอยู่มีใต้โคนต้น เชื้อสามารถเขาทำลายได้ทั้งใบอ่อนและใบแก",
    "ปกติดี",
    "การแพร่กระจายของโรค : สปอร์ของเชื้อราสาเหตุโรคจะฟุ้งกระจายอยู่ในอากาศ (Air-borne fungi) เมื่อลมพัดพาสปอร์ไปตกบริเวณ ที่มีอาหารสําหรับการเจริญเติบโต ของเชื้อราๆ จะสร้างเส้นใยไมซีเลียมและเจริญ อยู่ บนผิวใบ",
  ];
  var discriptions_3 = [
    "อาการของโรค : ใบแก่ของทุเรียนจะมีจุดฟูเขียวแกมเหลืองของสาหร่าย เกิดกระจายบนใบทุเรียน จุดจะพัฒนาและขยายออกและเปลียนเป็นสีเหลืองแกมส้มและในช่วงนี้สาหร่ายจะขยายพันธ์แพร่ระบาดต่อไป",
    "อาการของโรค : บนใบแผลเป็นจุดวงสีน้ำตาลแดงซ้อนกัน",
    "อาการของโรค : เชื้อจะเข้าทำลายที่บริเวณปลายใบไม้และขอบใบไม้ก่อน เกิดอาการปลายใบแห้ง และ ขอบใบแห้ง ที่จุดเชื้อสาเหตุเข้าทำลาย เนื้อใบส่วนนั้นจะแห้งเป็นสีน้ำตาลแดงในระยะแรก และต่อมาจะเปลี่ยนเป็นสีขาวอมเทา และเชื้อจะเจริญพัฒนาทำความเสียหายกับใบทุเรียน ขยายขนาดของพื้นที่เนื้อใบแห้งออกไปเรื่อยๆ เนื้อใบส่วนที่แห้งสีขาวอมเทามีการสร้าง ส่วนขยายพันธ์เป็นเม็ดสีดำกระจัดกระจายเต็มพื้นที่",
    "ปกติดี",
    "อาการของโรค : จุดราสีดำบนผิวใบ",
  ];
  var discriptions_4 = [
    "การป้องกันโรค : 1) ถ้ามีการระบาดของโรคมากแล้ว ควรผสมสารป้องกันกำจัดโรคพืชประเภทดูดซึมที่มีประสิทธภาพด้วย เช่นสาร กลุ่มรหัส 1( เบนโนมิล คาร์เบนดาซิม ไธอะเบนดาโซล ไทโอฟาเนทเมทิล) สารกลุ่มรหัส 3 ( ไตรฟอรีน โพรคลอราช ไดฟิโนโคนาโซล อีพ๊อกซีโคนาโซล เฮกซาโคนา โซลไมโคลบิวทานิล โพรพิโคนาโซล ทีบูโคนาโซล และ เตตราโคนาโซล เป็นต้น ) และสารกลุ่มที่มีรหัส 11 ( อะซ๊อกซีสโตรบิน ไพราโคลสโตรบิน ครึโซซิมเมทิล และ ไตรฟล๊อกซีสโตรบิน เป็นต้น) และ สลับด้วยสารประเภทสัมผัส เช่น สารกลุ่มคอปเปอร์ แมนโคเซ็บ โพรพิเนป และ คลอโรทาโลนิล เป็นต้น",
    "การป้องกันโรค : 1) เมื่อสำรวจพบอาการของโรค ควรพ่นสารป้องกันกำจัดโรคพืชเป็นระยะๆ เช่น คาร์เบนดาซิม, โพรคลาราซ, ไตรฟลอกซีสโตรบิน, โพรพิเนบ หรือ พ่นด้วยเชื้อราไตรโคเดอร์ม่า อัตราส่วน 1 กก./น้ำ 200 ลิตร พ่นซ้ำ 2-3 ครั้ง ห่างกัน 3-5 วัน หรืออัตราส่วนที่ระบุตามฉลาก",
    "การป้องกันโรค : 1) สารป้องกันกำจัดโรคพืชที่มีประสิทธิภาพ เช่นสาร กลุ่มรหัส 1( เบนโนมิล คาร์เบนดาซิม ไธอะเบนดาโซล ไทโอฟาเนทเมทิล) สารกลุ่มรหัส 3 ( ไตรฟอรีน โพรคลอราช ไดฟิโนโคนาโซล อีพ๊อกซีโคนาโซล เฮกซาโคนา โซลไมโคลบิวทานิล โพรพิโคนาโซล ทีบูโคนาโซล และ เตตราโคนาโซล เป็นต้น ) และสารกลุ่มที่มีรหัส 11 ( อะซ๊อกซีสโตรบิน ไพราโคลสโตรบิน ครึโซซิมเมทิล และ ไตรฟล๊อกซีสโตรบิน เป็นต้น) และ สลับด้วยสารประเภทสัมผัส เช่น สารกลุ่มคอปเปอร์ แมนโคเซ็บ โพรพิเนป และ คลอโรทาโลนิล 2) ตัดแต่งกิ่งที่เป็นโรค เพื่อลดปริมาณเชื้อสาเหตุในแปลงปลูก แล้วพ่นสารป้องกันกำจัดโรคพืชที่มีประสิทธิภาพ",
    "ปกติดี",
    "การป้องกันโรค : 1) มีการระบาดของโรคแล้ว ควรผสมสารป้องกันกำจัดโรคพืชที่มีประสิทธิภาพรวมไปด้วย เช่นสารกลุ่มรหัส 1 (เบนโนมิล คาร์เบนดาซิม ไธอะเบนดาโซล ไทโอฟาเนทเมทิล) สารกลุ่มรหัส 3 (ไตรฟอรีน โพรคลอราช ไดฟิโนโคนาโซล อีพ๊อกซีโคนาโซล เฮกซาโคนาโซล ไมโคลบิวทานิล โพรพิโคนาโซล ทีบูโคนาโซล และ เตตรานาโซล เป็นต้น) และสารกลุ่มรหัส 11 ( อะซ๊อกซีสโตรบิน ไพราโคลสโตรบิน ครีโซซิมเมทิล และ ไตรฟล๊อกซีสโตรบิน เป็นต้น) และ สลับด้วยสารประเภทสัมผัสเช่น สารกลุ่มคอปเปอร์ แมนโคเซ็บ โพรพิเนป และ คลอโรทาโลนิล เป็นต้น",
  ];

  @override
  void initState() {
    super.initState();
  }

  ClassifyImage(File imageFile) async {
    // var output = await Tflite.runModelOnImage(
    //   path: image.path,
    //   numResults: 5,
    //   threshold: 0.5,
    //   imageMean: 175.5,
    //   imageStd: 175.5,
    // );
    var url = 'https://durian-api-cloud.herokuapp.com/predict';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    var file = await http.MultipartFile.fromPath('file', imageFile.path);
    request.files.add(file);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    Map<String, dynamic> maps = jsonDecode(responseString);
    // List tmp = [];
    // // tmp[0] = response;
    // print("----------------------------------");
    // print(response);
    // print("----------------------------------");
    // print(responseData);
    // print("----------------------------------");
    // print(responseString);
    // print("----------------------------------");

    setState(() {
      _output = maps;
      // {
      // 'class': 'xxxx',
      // 'confidence': 123.3333333,
      // 'comment_2': 'xxxx',
      // 'comment_3': 'xxxx',
      // 'comment_4': 'xxxx',
      // };
      _loading = false;
    });
  }

  // loadModel() async {
  //   await Tflite.loadModel(
  //       model: 'assets/model.tflite', labels: 'assets/labels.txt');
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    // Tflite.close();
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
                                  '${_output['class']} : ${_output['confidence'].toStringAsFixed(2)} \n ${discriptions_1[_output['comment_1']]} \n ${discriptions_2[_output['comment_1']]} \n ${discriptions_3[_output['comment_1']]} \n ${discriptions_4[_output['comment_1']]}',
                                  style: TextStyle(
                                    color: Color.fromRGBO(27, 94, 32, 1),
                                  ))
                              : Container(),
                          SizedBox(height: 10),
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
