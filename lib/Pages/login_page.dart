import 'package:flutter/material.dart';
import 'package:flutter_fire_notes/All_Route/route_name.dart';
import 'package:flutter_fire_notes/utils/radio_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fire_notes/utils/toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void login() {
    if (_formkey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      _auth
          .signInWithEmailAndPassword(
              email: _emailController.text.toString(),
              password: _passwordController.text.toString())
          .then((value) {
        setState(() {
          loading = false;
        });
        Navigator.pushReplacementNamed(context, RouteName.notespage);
        Toast().FlutterToastShow(
          'Logged as ${value.user!.email.toString()}',
        );
      }).onError((error, stackTrace) {
        setState(() {
          loading = false;
        });
        Toast().FlutterToastShow(
          error.toString(),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 98, 131, 207),
              Color.fromARGB(255, 16, 35, 71),
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 120, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins'),
                  ),
                  SizedBox(height: 50),
                  Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0, 2))
                                ]),
                            height: 60,
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Color(0xff182848),
                                  ),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(color: Colors.black38)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter email';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0, 2))
                                ]),
                            height: 60,
                            child: TextFormField(
                              controller: _passwordController,
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Color(0xff182848),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.black38)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter password';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  RadioButton(
                    title: 'LOGIN',
                    color: Colors.white,
                    isLoading: loading,
                    onTap: () {
                      login();
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, RouteName.signuppage);
                      },
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Don\'t have an Account? ',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                        ]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
