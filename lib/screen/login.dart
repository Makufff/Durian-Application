// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_1/models/profile.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              appBar: AppBar(
                title: const Text("Error"),
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
                title: Center(child: Text("Login")),
                backgroundColor: Colors.green.shade900,
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          buildLogo(),
                          buildEmail(),
                          buildPassword(),
                          // Login button
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: SizedBox(
                              width: screen * 0.8,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green.shade800,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Text("เข้าสู่ระบบ",
                                    style: TextStyle(fontSize: 20)),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    try {
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: profile.email,
                                              password: profile.password)
                                          .then((value) {
                                        formKey.currentState!.reset();
                                        Navigator.pushNamedAndRemoveUntil(
                                            context, '/home', (route) => false);
                                      });
                                      ;
                                    } on FirebaseAuthException catch (e) {}
                                  }
                                },
                              ),
                            ),
                          ),
                          // Register button
                          SizedBox(
                              width: screen * 0.8,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: Text(
                                  "สมัครสมาชิก",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                              ))
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

  Container buildLogo() {
    return Container(
      width: screen * 0.45,
      child: Image.asset("assets/Logo.png"),
    );
  }

  Container buildEmail() {
    return Container(
      width: screen * 0.8,
      margin: EdgeInsets.only(top: 16),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: "อีเมล : ",
            prefixIcon: Icon(
              Icons.email_rounded,
              color: Colors.green.shade800,
            ),
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
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.8,
      child: TextFormField(
        obscureText: statusRedEye,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: statusRedEye
                  ? Icon(
                      Icons.remove_red_eye,
                      color: Colors.green.shade800,
                    )
                  : Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.green.shade800,
                    ),
              onPressed: () {
                setState(() {
                  statusRedEye = !statusRedEye;
                });
              },
            ),
            hintText: "รหัสผ่าน : ",
            prefixIcon: Icon(
              Icons.lock_rounded,
              color: Colors.green.shade800,
            ),
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
