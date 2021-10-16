import 'package:demo/pages/verifyagain/elements/verifyagain.dart';
import 'package:flutter/material.dart';
import 'package:demo/size_settings.dart';
import 'package:demo/constants.dart';
import 'package:demo/components/socal_card.dart';
import 'package:demo/pages/signup/elements/SignUp.dart';

class VerifyMain extends StatelessWidget {
  final String email;
  final String password;
  final String lastname;
  final String firstname;
  final String gender;
  final int day;
  final int month;
  final int year;

  VerifyMain({
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
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                        Text("Almost done!", style: headingStyle),
                        Text(
                          "we've sent the code to the email: \n $email",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.08),
                        VerifyagainScreen(
                          email: email,
                          password: password,
                          lastname: lastname,
                          firstname: firstname,
                          gender: gender,
                          day: day,
                          month: month,
                          year: year,
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.08),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocalCard(
                              icon: "assets/icons/google-icon.svg",
                              press: () {},
                            ),
                            SocalCard(
                              icon: "assets/icons/facebook-2.svg",
                              press: () {},
                            ),
                            SocalCard(
                              icon: "assets/icons/twitter.svg",
                              press: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        Text(
                          'By clicking the Sign Up button,you agree to \nour Term & Condition and Privacy Policy',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
