import 'dart:ui';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:partyapp/animations/fade_in_slide.dart';
import 'package:partyapp/config/color_config.dart';
import 'package:partyapp/viewmodels/auth_VM.dart';
import 'package:partyapp/viewmodels/signup_VM.dart';
import 'package:partyapp/views/otp_view.dart';
import 'package:partyapp/widgets/background_template.dart';
import 'package:partyapp/widgets/loadingscreen.dart';
import 'package:partyapp/widgets/submitbutton.dart';
import 'package:partyapp/widgets/textfield.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController city = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Key for form validation

  @override
  Widget build(BuildContext context) {
    final signupViewModel = Provider.of<SignUpViewModel>(context);
    final authViewModel =
        Provider.of<AuthViewModel>(context); // Provide AuthViewModel

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: StackTemplate(
        child: authViewModel.isloading
            ? Container()
            : Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Form(
                      key: _formKey, // Assigning form key
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FadeInSlide(
                            duration: 0.6,
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: screenWidth * 0.1,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          
                          SizedBox(height: screenHeight * 0.02),
                          FadeInSlide(
                            duration: 0.5,
                            child: CustomTextField(
                              controller: phone,
                              type: TextInputType.phone,
                              hintText: "987XXXXXXX",
                              icon: Icons.phone_outlined,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                if (value.length != 10) {
                                  return 'Phone number must be 10 digits';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                         
                          FadeInSlide(
                            duration: 0.7,
                            child: Container(
                              height: screenHeight * 0.07,
                              child: Row(
                                children: [
                                  ValueListenableBuilder(
                                    valueListenable: signupViewModel.termsCheck,
                                    builder: (context, value, child) {
                                      return CupertinoCheckbox(
                                        inactiveColor: Colors.white,
                                        value: signupViewModel.termsCheck.value,
                                        onChanged: (_) {
                                          signupViewModel.toogleTerms();
                                        },
                                      );
                                    },
                                  ),
                                  Flexible(
                                    child: InkWell(
                                      onTap: () {
                                        signupViewModel.toogleTerms();
                                      },
                                      child: Ink(
                                        child: Text(
                                          "By continuing you accept our Privacy Policy and Terms of Service",
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: screenWidth * 0.04,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.05),
                          SubmitButton(
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                            onPressed: () async {
                              if (_formKey.currentState!.validate() &&
                                  signupViewModel.validateTerms()) {
                                LoadingScreen.instance()
                                    .show(context: context, text: "Sign In...");
                                await authViewModel.signInWithPhoneNumber(
                                  "+91${phone.text}",
                                  context,
                                );
                                // await Future.delayed(
                                //     const Duration(seconds: 1));
                                for (var i = 0; i <= 100; i++) {
                                  LoadingScreen.instance()
                                      .show(context: context, text: '$i...');
                                  await Future.delayed(
                                      const Duration(milliseconds: 10));
                                }
                                LoadingScreen.instance().show(
                                    context: context,
                                    text: "Signed In Successfully");
                                await Future.delayed(
                                    const Duration(seconds: 1));
                                LoadingScreen.instance().hide();
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                        "Please accept the terms and conditions to continue.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor:
                                        const Color.fromARGB(255, 59, 59, 59),
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
