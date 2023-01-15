

import 'package:flutter/material.dart';
import 'package:flutter_fire_notes/All_Route/route_name.dart';
import 'package:flutter_fire_notes/All_Route/route_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteName.splacepage,
      onGenerateRoute: RouteNavigate.generateRoute,
    );
  }
}
