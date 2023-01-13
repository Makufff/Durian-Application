import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_1/models/profile.dart';
import 'package:flutter_application_1_1/screen/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final database = FirebaseDatabase.instance.ref();
  final FirebaseAuth auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(name: '', email: '', password: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  double screen = 0;
  bool statusRedEye = true;

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              backgroundColor: const Color.fromRGBO(245, 243, 193, 1),
              appBar: AppBar(
                title: Text("Error"),
                backgroundColor: Colors.green.shade800,
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: const Color.fromRGBO(245, 243, 193, 1),
              appBar: AppBar(
                title: Text("Register"),
                backgroundColor: Colors.green.shade800,
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          buildName(),
                          buildEmail(),
                          buildPassword(),
                          // Register button
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: SizedBox(
                              width: screen * 0.9,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green.shade800,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: const Text("ลงทะเบียน",
                                    style: TextStyle(fontSize: 20)),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    try {
                                      await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                              email: profile.email,
                                              password: profile.password)
                                          .then((value) async {
                                        formKey.currentState!.reset();
                                        final uid = await auth.currentUser!.uid;

                                        database.child('$uid/').set({
                                          'name': 'Zhongli',
                                          'text':
                                              'Hana to sake wo te ni keshiki wo tannou shiyou to shita ga, ano koro towa mou chigau. Kyuuyuu to mata...'
                                        });
                                        // ignore: use_build_context_synchronously
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const LoginScreen();
                                        }));
                                      });
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'email-already-in-use') {
                                        Fluttertoast.showToast(
                                            msg: "อีเมลนี้ได้ลงทะเบียนแล้ว",
                                            gravity: ToastGravity.CENTER);
                                      }
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Container buildName() {
    return Container(
      width: screen * 0.9,
      margin: EdgeInsets.only(top: 16),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: "ชื่อผู้ใช้ : ",
            prefixIcon: Icon(Icons.account_circle_rounded,
                color: Colors.green.shade800),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.green.shade800))),
        validator: MultiValidator(
            [RequiredValidator(errorText: "กรุณากรอกชื่อผู้ใช้")]),
        onSaved: (String? name) {
          profile.name = name!;
        },
      ),
    );
  }

  Container buildEmail() {
    return Container(
      width: screen * 0.9,
      margin: EdgeInsets.only(top: 16),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: "อีเมล : ",
            prefixIcon: Icon(Icons.email_rounded, color: Colors.green.shade800),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.green.shade800))),
        validator: MultiValidator([
          RequiredValidator(errorText: "กรุณากรอกอีเมล"),
          EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
        ]),
        keyboardType: TextInputType.emailAddress,
        onSaved: (String? email) {
          profile.email = email!;
        },
      ),
    );
  }

  Container buildPassword() {
    return Container(
      width: screen * 0.9,
      margin: EdgeInsets.only(top: 16),
      child: TextFormField(
        obscureText: statusRedEye,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: statusRedEye
                  ? Icon(Icons.remove_red_eye, color: Colors.green.shade800)
                  : Icon(Icons.remove_red_eye_outlined,
                      color: Colors.green.shade800),
              onPressed: () {
                setState(() {
                  statusRedEye = !statusRedEye;
                });
              },
            ),
            hintText: "รหัสผ่าน : ",
            prefixIcon: Icon(Icons.lock_rounded, color: Colors.green.shade800),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.green.shade800))),
        validator: (String? value) {
          if (value == null || value.trim().length == 0) {
            return "กรุณากรอกรหัสผ่าน";
          }
          if (value.length < 6) {
            return "รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร";
          }
          return null;
        },
        onSaved: (String? password) {
          profile.password = password!;
        },
      ),
    );
  }
}
