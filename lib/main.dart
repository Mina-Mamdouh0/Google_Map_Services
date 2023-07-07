import 'package:flutter/material.dart';
import 'package:map/button_screen.dart';
import 'package:map/login_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
class Data{
  static double latCurrent=0.0;
  static double lngCurrent=0.0;

  static double latOther=0.0;
  static double lngOther=0.0;
  static String location='';
}
class DataDiv{
  static double latCurrent=0.0;
  static double lngCurrent=0.0;
  static double latOther=0.0;
  static double lngOther=0.0;
}

