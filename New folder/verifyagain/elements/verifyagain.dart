import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/pages/login_success/login_success_screen.dart';
import 'package:demo/pages/sign_in/sign.dart';
import 'package:demo/pages/userinfon/user_infon.dart';
import 'package:demo/pages/userinfon/user_infon.dart';
import 'package:flutter/material.dart';
import 'package:demo/size_settings.dart';
import 'package:demo/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:demo/components/form_error.dart';
import 'package:demo/components/default_button.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';
import 'package:email_auth/email_auth.dart';

import '../../../auth.config.dart';

class VerifyagainScreen extends StatefulWidget {
  final String email;
  final String password;
  final String lastname;
  final String firstname;
  final String gender;
  final int day;
  final int month;
  final int year;

  VerifyagainScreen({
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
  @override
  _VerifyagainScreenState createState() => _VerifyagainScreenState();
}

class _VerifyagainScreenState extends State<VerifyagainScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otp = TextEditingController();
  String email;

  bool remember = false;
  final List<String> errors = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final firestoreInstance = FirebaseFirestore.instance;

  // Sending OTP with Email_auth
  EmailAuth emailAuth;

  @override
  void initState() {
    super.initState();
    emailAuth = new EmailAuth(
      sessionName: "Sample session",
    );
    emailAuth.config(remoteServerConfiguration);
  }

  void sendOtp() async {
    bool result =
        await emailAuth.sendOtp(recipientMail: widget.email, otpLength: 5);
  }

  void sendaOtp() async {
    bool result =
        await emailAuth.sendOtp(recipientMail: widget.email, otpLength: 5);
    if (result == true) {
      print("otp sent agaim");
      Toast.show(
        "OTP sent to ${widget.email}",
        context,
        gravity: Toast.TOP,
        duration: Toast.LENGTH_LONG,
      );
    } else {
      Toast.show(
        "Something went wrong Please Try Again",
        context,
        gravity: Toast.TOP,
        duration: Toast.LENGTH_LONG,
      );
    }
  }

  void verifyotp() async {
    if (emailAuth.validateOtp(
        recipientMail: widget.email, userOtp: _otp.text)) {
      print("verified");
      var currentUser = _auth.currentUser;
      firestoreInstance.collection("Users").doc(widget.email).set({
        "First Name": widget.firstname,
        "Last Name": widget.lastname,
        "Pssword": widget.password,
        "Email": widget.email,
        "Gender": widget.gender,
        "Date Of Birth": {
          "Day Of Birth": widget.day,
          "Month Of Birth": widget.month,
          "Year Of Birth": widget.year,
        }
      }).then((value) {
        FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: widget.email, password: widget.password);
      });
      Navigator.pushNamed(context, LoginSuccessScreen.routeName);
    } else {
      print("object");
      Toast.show(
        "You have Entered the Wrong OTP",
        context,
        gravity: Toast.TOP,
        duration: Toast.LENGTH_LONG,
      );
    }
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    sendOtp();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 20),
            child: DefaultButton(
              text: "Continue",
              press: () {
                verifyotp();

                // print(widget.email);
                // print(widget.password);
                // print(widget.lastname);
                // print(widget.firstname);
                // print(widget.gender);
                // print(widget.day);
                // print(widget.month);
                // print(widget.year);
              },
            ),
          ),
          // DefaultButton(
          //   text: "send",
          //   press: () => sendOtp(),
          // ),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _otp,
      decoration: InputDecoration(
        suffixIcon: TextButton(
          child: Text("Resend"),
          onPressed: () => sendaOtp(),
        ),
        labelText: "OTP", labelStyle: TextStyle(color: Color(0xFF1A237E)),
        hintText: "Enter the OTP",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  // void _onPressed() {
  //   final FirebaseAuth _auth = FirebaseAuth.instance;

  //   var currentUser = _auth.currentUser;
  //   if (_formKey.currentState.validate()) {
  //     _formKey.currentState.save();
  //     try {
  //       currentUser.sendEmailVerification();
  //       Navigator.pushNamed(context, signin.routeName);
  //       Toast.show(
  //         "Varification Email Sent to Your Email",
  //         context,
  //         gravity: Toast.TOP, duration: Toast.LENGTH_LONG,
  //       );
  //     } catch (e) {
  //       Toast.show(
  //         "This Email Is Already Registred",
  //         context,
  //         gravity: Toast.TOP, duration: Toast.LENGTH_LONG,
  //       );
  //       print(e);
  //     }
  //   }
  // }
}
