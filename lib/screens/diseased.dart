import 'package:flutter/material.dart';

class DiseasedScreen extends StatefulWidget {
  final int pageidx;
  final double screen;
  const DiseasedScreen({
    Key? key,
    required this.pageidx,
    required this.screen,
  }) : super(key: key);

  @override
  State<DiseasedScreen> createState() => _DiseasedScreenState();
}

class _DiseasedScreenState extends State<DiseasedScreen> {
  int pageidx = 0;

  @override
  void initState() {
    super.initState();
    pageidx = widget.pageidx;
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: pageidx);
    double screen = widget.screen;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 243, 193, 5),
      appBar: AppBar(
        title: const Text("Diseases of durian"),
        backgroundColor: const Color.fromRGBO(27, 94, 32, 1),
      ),
      body: PageView(controller: controller, children: [
        DiseasedInfo(
          photo: 'assets/leaf/anthracnose.png',
          name: 'Anthracnose',
          cause: 'เกิดจากเชื้อรา Colletotrichum zibethinum Sacc.',
          spread: 'ลมและฝนพัดพาโรคจากใบและกิ่งสู่ดอก',
          sym: 'อาการบนใบแผลเป็นจุดวงสีน้ำตาลแดงซ้อนกัน',
          protect:
              'เมื่อสำรวจพบอาการของโรค ควรพ่นสารป้องกันกำจัดโรคพืชเป็นระยะๆ เช่น คาร์เบนดาชิม, โพรคลาราช, ไตรฟลอกชีสโตรบิน, โพรพิเนบ หรือ พ่นด้วยเชื้อราไตรโคเดอร์ม่า อัตราส่วน 1 กก./น้ำ 200 ลิตร พ่นช้ า 2-3 ครั้ง ห่างกัน 3-5 วัน หรืออัตราส่วนที่ระบุตามฉลาก',
          screen: screen,
          boxh1: 180,
          boxh2: 230,
        ),
        DiseasedInfo(
          photo: 'assets/leaf/sootymold.png',
          name: 'Sooty Mold',
          cause: 'เกิดจากเชื้อรา Capnodium sp. Mont.',
          spread:
              'สปอร์ ของเชื้อราสาเหตุโรคจะฟุ้งกระจายอยู่ในอากาศ (Air-borne fungi) เมื่อลมพัดพาสปอร์ไปตกบริเวณ ที่มีอาหารสำหรับการเจริญเติบโต ของเชื้อราๆ จะสร้างเส้นใยไมซีเลียมและเจริญ อยู่ บนผิวใบ',
          sym: 'จุดราสีดำบนผ้าใบ',
          protect:
              'มีการระบาดของโรคแล้ว ควรผสมสารป้องกันกำจัดโรคพืชที่มีประสิทธิภาพร่วมไปด้วย เช่น\nสารกลุ่มรหัส 1 (เบนโนมิล คาร์เบนดาซิม ไธอะเบนดาโซล ไทโอฟาเนทเมทิล) \nสารกลุ่มรหัส 3 (ไตรฟอรีน โพรคลอราช ไดฟิ โนโคนาโซล อีพ๊อกชีโคนโชล เฮกซโคนาโชล ไมโคลบิวทานิล โพรพิโคนาโซล ที่บูโคนาโซล และ เตตรานโซล เป็นต้น) \nและสารกลุ่มรหัส 11 ( อะช็อกซีสโตรบิน ไพราโคลสโตรบิน ครีโซชิมเมทิล และ ไตรฟล๊อกชีสโตรบิน เป็นต้น) \nและสลับด้วยสารประเภทสัมผัส เช่น สารกลุ่มคอปเปอร์ แมนโคเซ็บ โพรพิเนป และคลอโรทาโลนิล',
          screen: screen,
          boxh1: 245,
          boxh2: 400,
        ),
        DiseasedInfo(
          photo: 'assets/leaf/agalspot.png',
          name: 'Agal Spot',
          cause: 'เกิดจาก สาหร่าย Cephaleuros virescens Kunze',
          spread:
              'แพร่ระบาดไปกับลมและพายุฝน เข้าทำลายในสภาพอากาศที่มีความชื้นสูง นอกจากนี้ น้ำก็เป็นพาทะนำสปอร์ไปสู่ต้นอื่นได้เช่นเดียวกัน',
          sym:
              'ใบแก่ของทุเรียนจะมีจุดฟูเขียวแกมเหลืองของสาหร่าย เกิดกระจายบนใบทุเรียน จุดจะพัฒนาและขยายออกและเปลี่ยนเป็นสีเหลืองแกมส้มและในช่วงนี้สาหร่ายจะขยายพันธ์แพร่ระบาดต่อไป',
          protect:
              'ถ้ามีการระบาดของโรคมากแล้ว ควรผสมสารป้องกันกำจัดโรคพืชประเภทดูดซึมที่มีประสิทธิภาพด้วย เช่น \nสารกลุ่มรหัส 1( เบนโนมิล คาร์เบนดาชิม ไธอะเบนดาโซล ไทโอฟาเนทเมทิล) \nสารกลุ่มรหัส 3 ( ไตรฟอรีน โพรคลอราช ไดฟิ โนโคนโซล อีพ้อก โคนาโซล เฮกชาโคนาโซล ไมโคลบิวทานิล โพรพิโคนาโซล ที่บูโคนาโซล และเตตราโคนาโซล ) \nและสารกลุ่มมรหัส 11 ( อะช้อกชีสโตรบิน ไพราโคลสโตรบิน ครีโซชิมเมทิล และไตรฟล๊อกชีสโตรบิน ) \nและสลับด้วยสารประเภทสัมผัส เช่น สารกลุ่มคอปเปอร์ แมน โคเซ็บ โพรพิเนปและ คลอโรทาโลนิล เป็นต้น',
          screen: screen,
          boxh1: 320,
          boxh2: 400,
        ),
        DiseasedInfo(
          photo: 'assets/leaf/leftblinght.png',
          name: 'Left Blingh',
          cause: 'เกิดจากเชื้อรา Phomopsis sp.',
          spread:
              'จะแพร่ระบาดไปโดยลม และฝน และจากเนื้อเยื่อใบที่แห้งและหล่นตกค้างอยู่มีใต้โคนต้น',
          sym:
              'เชื้อสามารถเข้าทำลายได้ทั้งใบอ่อนและใบแก่เชื้อจะเข้าทำลายที่บริเวณปลายใบไม้และขอบใบไม้ก่อน เกิดอาการปลายใบแห้ง และ ขอบใบแห้ง ที่จุดเชื้อสาเหตุเข้าทำลาย เนื้อใบส่วนนั้นจะแห้งเป็นสีน้ำตาลแดงในระยะแรก และต่อมาจะเปลี่ยนเป็นสีขาวอมเทา และเชื้อจะเจริญพัฒนาทำความเสียหายกับใบทุเรียน ขยายขนาดของพื้นที่เนื้อใบแห้งออกไปเรื่อยๆ เนื้อใบส่วนที่แห้งสีขาวอมเทามีการสร้างส่วนขยายพันธุ์เป็นเม็ดสีดำกระจัดกระจายเต็มพื้นที่',
          protect:
              'ตัดแต่งกิ่งที่ป็นโรค เพื่อลดปริมาณเชื้อสาเหตุในแปลงปลูก แล้วพ่นสารป้องกันกำจัดโรคพืชที่มีประสิทธิภาพ สารป้องกันกำจัดโรคพืชที่มีประสิทธิภาพ เช่น\nสารกลุ่มรหัส 1( เบน โนมิล คาร์เบนดาซิม ไธอะเบนดาโซล ไทโอฟาเนทเมทิล) \nสารกลุ่มรหัส 3 ( ไตรฟอรีน โพรคลอราช ไดฟิ โน โคนาโซล อึอก โคนาโซล เฮกซาโคนาโซล ไมโคลบิวทานิล โพรพิ โคนาโซล ที่บูโคนาโซลและ เตตรานาโซล )  \nและสารกลุ่มรหัส 11 ( ช็อกซีสโตรบิน ไพรโคลสโตรบิน ครีโซชิมเมล และ ไตรฟล๊อกชีสโตรบิน) \nและสลับด้วยสารประเภทสัมผัส เช่น สารกลุ่มคอปเปอร์ แมนโคเช็บ โพรพิเนปและคลอโรทาโลนิล',
          screen: screen,
          boxh1: 430,
          boxh2: 440,
        ),
      ]),
    );
  }
}

class DiseasedInfo extends StatefulWidget {
  final String photo;
  final String name;
  final String cause;
  final String spread;
  final String sym;
  final String protect;
  final double screen;
  final double boxh1;
  final double boxh2;
  const DiseasedInfo({
    Key? key,
    required this.photo,
    required this.name,
    required this.cause,
    required this.spread,
    required this.sym,
    required this.protect,
    required this.screen,
    required this.boxh1,
    required this.boxh2,
  }) : super(key: key);

  @override
  State<DiseasedInfo> createState() => _DiseasedInfoState();
}

class _DiseasedInfoState extends State<DiseasedInfo> {
  @override
  Widget build(BuildContext context) {
    double screen = widget.screen;
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 25, bottom: 30),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 230,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Container(
                        height: 180,
                        width: screen * 0.9,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 102, 100, 100),
                                  spreadRadius: 1,
                                  blurRadius: 9,
                                  offset: Offset(5, 5)),
                              BoxShadow(
                                  color: Color.fromARGB(255, 210, 211, 163),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(-4, -4))
                            ]),
                      ),
                    ),
                  ),
                  Positioned(
                      left: 15,
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.black.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          width: screen * 0.4,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(widget.photo))),
                        ),
                      )),
                  Positioned(
                      top: 60,
                      left: screen * 0.43,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Container(
                          height: 150,
                          width: screen * 0.4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 18, 51, 20)),
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  widget.cause,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                height: widget.boxh1,
                width: screen * 0.9,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(80)),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 102, 100, 100),
                          spreadRadius: 1,
                          blurRadius: 9,
                          offset: Offset(5, 5)),
                      BoxShadow(
                          color: Color.fromARGB(255, 210, 211, 163),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(-4, -4))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 35, 20),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "การแเพร่กระจายของโรค :",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 18, 51, 20)),
                        ),
                        Text(
                          widget.spread,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "อาการ :",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 18, 51, 20)),
                        ),
                        Text(
                          widget.sym,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                height: widget.boxh2,
                width: screen * 0.9,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(80)),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 102, 100, 100),
                          spreadRadius: 1,
                          blurRadius: 9,
                          offset: Offset(5, 5)),
                      BoxShadow(
                          color: Color.fromARGB(255, 210, 211, 163),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(-4, -4))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "การป้องกัน :",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 18, 51, 20)),
                        ),
                        Text(
                          widget.protect,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
