import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_fire_notes/All_Route/route_name.dart';

class SplaceServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      Timer(Duration(seconds: 3), (() {
        Navigator.pushReplacementNamed(context, RouteName.notespage);
      }));
    } else {
      Timer(Duration(seconds: 3), (() {
        Navigator.pushReplacementNamed(context, RouteName.loginpage);
      }));
    }
  }
}
