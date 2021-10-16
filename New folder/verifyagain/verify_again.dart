import 'package:demo/pages/verifyagain/elements/verifyagain.dart';
import 'package:flutter/material.dart';
import 'package:demo/pages/verifyagain/elements/body.dart';

class Verifyagain extends StatelessWidget {
  final String email;
  final String password;
  final String lastname;
  final String firstname;
  final String gender;
  final int day;
  final int month;
  final int year;

  Verifyagain({
    Key key,
    @required this.email,
    @required this.password,
    @required this.lastname,
    @required this.firstname,
    @required this.gender,
    @required this.day,
    @required this.month,
    @required this.year,
  }) : super(key: key);
  static String routeName = "/Verify_again";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Verify Your Email",
          style: TextStyle(color: Color(0xFF1A237E)),
        ),
      ),
      body: VerifyMain(
        email: email,
        password: password,
        lastname: lastname,
        firstname: firstname,
        gender: gender,
        day: day,
        month: month,
        year: year,
      ),
    );
  }
}
