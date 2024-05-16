import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:partyapp/views/all_details_view.dart';
import 'package:partyapp/views/language_view.dart';
import 'package:partyapp/views/otp_view.dart';

class AuthViewModel extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? verificationId;
  bool isloading = false;
  Future<void> signInWithPhoneNumber(
      String phoneNumber, BuildContext context) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Automatically sign in if verification is completed
          await _auth.signInWithCredential(credential);

          // Navigate to next screen
          // For example:
          // Navigator.push(context, MaterialPageRoute(builder: (_) => NextScreen()));
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure
          print('Verification Failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId = verificationId;
          log("the verification id is $verificationId");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPInputView(
                  //phone: phone.text,
                  ),
            ),
          );
          // Handle code sent
          // For example:
          // Navigator.push(context, MaterialPageRoute(builder: (_) => OTPScreen(verificationId: verificationId)));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle code auto retrieval timeout
        },
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> verifyOTP(String otp, BuildContext context) async {
    log("the verification id is $verificationId");
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otp,
      );
      print("the verification id is $verificationId");
      print("the otp is entered is $otp");
      await _auth.signInWithCredential(credential);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => GetAllDetailsScreen()));
      // Verification successful, navigate to next screen
      // For example:
      // Navigator.push(context, MaterialPageRoute(builder: (_) => NextScreen()));
    } catch (e) {
      print('Error verifying OTP: $e');
      // Handle error, maybe show a snackbar or toast
    }
  }
}
