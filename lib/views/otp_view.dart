import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:partyapp/animations/fade_in_slide.dart';
import 'package:partyapp/config/color_config.dart';
import 'package:partyapp/viewmodels/auth_VM.dart';
import 'package:partyapp/widgets/background_template.dart';
import 'package:partyapp/widgets/submitbutton.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPInputView extends StatelessWidget {
  final String? phone;
  late String pinvalue;
  OTPInputView({super.key, this.phone});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final count = ValueNotifier(6);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      count.value--;
      if (timer.tick == 6 || !context.mounted) {
        timer.cancel();
      }
    });

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        // appBar: AppBar(),
        body: StackTemplate(
          child2: Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: ValueListenableBuilder(
              valueListenable: count,
              builder: (context, value, child) {
                return Padding(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: Column(
                    children: [
                      SubmitButton(
                          onPressed: () async {
                            // log(pin);
                            await authViewModel.verifyOTP("123456", context);
                          },
                          screenWidth: screenWidth,
                          screenHeight: screenHeight),
                      const SizedBox(height: 20),
                      FadeInSlide(
                        duration: .7,
                        child: Text("You can resend the code in $value seconds",
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            )
                            // textAlign: TextAlign.center,
                            ),
                      ),
                      const SizedBox(height: 10),
                      FadeInSlide(
                        duration: .8,
                        child: TextButton(
                          onPressed: value > 0 ? null : () {},
                          child: const Text("Resend Code",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              )),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 20),
              const FadeInSlide(
                duration: .4,
                child: Text("OTP Verification 🔐",
                    style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
              const SizedBox(height: 15),
              FadeInSlide(
                duration: .5,
                child: Text(
                    // "Enter the 4-digit code sent to your phone number +91 ${phone.substring(0, 4)} XXXXXX",
                    "Enter the 4-digit code sent to your phone number +91 9999 XXXXXX",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    )),
              ),
              const SizedBox(height: 40),
              _buildPinPut(context),
              const SizedBox(height: 40),
            ],
          ),
        ));
  }

  Widget _buildPinPut(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    final defaultPinTheme = PinTheme(
      width: 80,
      height: 70,
      textStyle: const TextStyle(
          fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
      decoration: BoxDecoration(
        color: const Color(0xff1f2128),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      color: const Color(0xff1f2128),
      border: Border.all(color: AppColors.buttonColor, width: 2),
      borderRadius: BorderRadius.circular(15),
    );

    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      color: const Color(0xff1f2128),
      border: Border.all(color: AppColors.buttonColor, width: 2),
      borderRadius: BorderRadius.circular(15),
    );

    return FadeInSlide(
      duration: .6,
      child: Pinput(
        length: 6,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        submittedPinTheme: submittedPinTheme,
        // validator: (s) {
        //   return s == '2222' ? 'Pin is correct' : 'Pin is incorrect';
        // },
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,
        autofocus: true,
        onCompleted: (pin) async {
          log(pin);
          pinvalue = pin;
          try {
            await authViewModel.verifyOTP(pin, context);
            // OTP verification successful, navigate to next screen
            print("correct");
          } catch (e) {
            // Handle incorrect OTP
            print("incorrect");
          }
        },
      ),
    );
  }
}
