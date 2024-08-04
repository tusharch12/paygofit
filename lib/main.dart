import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:paygofit/page/home_page.dart';
import 'package:paygofit/page/main_page.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyDIbKnoUVtt7gT9WAxUNSrWgo_sbsNm268',
         projectId: 'paygo-6350f',
      storageBucket: 'paygo-6350f.appspot.com',
      messagingSenderId: 'YOUR_SENDER_ID',
      appId: '1:968189749436:android:8e2c9e227221e9f7a348b9',
      measurementId: 'YOUR_MEASUREMENT_ID',
    ));
  } catch (e) {
    print("Failed to initialize Firebase: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}


