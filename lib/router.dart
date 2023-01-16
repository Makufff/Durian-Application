import 'package:flutter/material.dart';
import 'package:flutter_application_1_1/screen/drone.dart';
import 'package:flutter_application_1_1/screen/home.dart';
import 'package:flutter_application_1_1/screen/login.dart';
import 'package:flutter_application_1_1/screen/register.dart';
import 'package:flutter_application_1_1/screen/result.dart';
import 'package:flutter_application_1_1/screen/TfliteModel.dart';
// import 'package:flutter_applocation_1/screen/imagepro.dart';

final Map<String, WidgetBuilder> routes = {
  '/home': (BuildContext context) => const HomeScreen(),
  '/login': (BuildContext context) => const LoginScreen(),
  '/register': (BuildContext context) => const RegisterScreen(),
  '/drone': (BuildContext context) => const DroneScreen(),
  '/result': (BuildContext context) => const ResultScreen(),
  '/image': (BuildContext context) => TfliteModel(),
};
