import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_1/blocs/application_bloc.dart';
import 'package:flutter_application_1_1/router.dart';
import 'package:provider/provider.dart';

String initialRoute = '/login';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        initialRoute = '/home';
      }
      runApp(MyApp());
    });
  });
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  // final locatorService = GeolocatorService();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        // routes: routes,
        // initialRoute: initialRoute,
        home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              // ignore: avoid_print
              print('You have an error! ${snapshot.error.toString()}');
              return const Text('Error');
            } else if (snapshot.hasData) {
              return MaterialApp(
                routes: routes,
                initialRoute: initialRoute,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
