import 'package:flutter/material.dart';
import 'package:flutter_fire_notes/services/splace_services.dart';

class SplacePage extends StatefulWidget {
  const SplacePage({super.key});

  @override
  State<SplacePage> createState() => _SplacePageState();
}

class _SplacePageState extends State<SplacePage> {
  @override
  void initState() {
    super.initState();
    SplaceServices().isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color(0xff4b6cb7),
            Color(0xff182848),
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: FlutterLogo(size: 35),
          ),
        ),
      ),
    );
  }
}
