import 'package:flutter/material.dart';
import 'package:holter_app/screens/login_screen.dart';
import 'package:holter_app/screens/main_screen.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Holter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
      routes: {
        'holter_app/screens/main_screen.dart' :(context) => const HealtMonitoringPage()
      },
    );
  }
}