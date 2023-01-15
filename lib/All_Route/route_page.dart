import 'package:flutter/material.dart';
import 'package:flutter_fire_notes/All_Route/route_name.dart';
import 'package:flutter_fire_notes/Pages/login_page.dart';
import 'package:flutter_fire_notes/Pages/notes_page.dart';
import 'package:flutter_fire_notes/Pages/sign_up.dart';
import 'package:flutter_fire_notes/Pages/splace.dart';

class RouteNavigate {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splacepage:
        return MaterialPageRoute(builder: ((context) => SplacePage()));
      case RouteName.loginpage:
        return MaterialPageRoute(builder: ((context) => LoginPage()));
      case RouteName.signuppage:
        return MaterialPageRoute(builder: ((context) => SignUpPage()));
      case RouteName.notespage:
        return MaterialPageRoute(builder: ((context) => NotesPage()));
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
