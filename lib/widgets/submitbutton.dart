import 'package:flutter/material.dart';
import 'package:partyapp/animations/fade_in_slide.dart';
import 'package:partyapp/config/color_config.dart';
import 'package:partyapp/views/otp_view.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.onPressed,
  });
  final void Function()? onPressed;
  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return FadeInSlide(
      duration: 0.8,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: AppColors.buttonColor,
          fixedSize: Size(screenWidth * 1, screenHeight * 0.07),
        ),
        onPressed:onPressed,
        child: Text(
          'Continue',
          style: TextStyle(
              fontSize: screenWidth * 0.06,
              color: Colors.white),
        ),
      ),
    );
  }
}