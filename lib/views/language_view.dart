import 'package:flutter/material.dart';

import 'package:partyapp/animations/fade_in_slide.dart';
import 'package:partyapp/views/login_view.dart';
import 'package:partyapp/views/signup_view.dart';

class GetStartedView extends StatelessWidget {
  const GetStartedView({Key? key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            FadeInSlide(
              duration: .4,
              child: Image.asset(
                "assets/admk.png",
                height: 200,
              ),
            ),
            const Spacer(),
            FadeInSlide(
              duration: .5,
              child: Text(
                "Let's get started",
                style: theme.textTheme.headline6!
                    .copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: height * 0.015),
            const FadeInSlide(
              duration: .6,
              child: Text(
                "Authenticate yourself to continue",
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            const Spacer(),
            FadeInSlide(
              duration: 1.1,
              child: FilledButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage())),
                style: FilledButton.styleFrom(
                  fixedSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            FadeInSlide(
              duration: 1.2,
              child: FilledButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage())),
                style: FilledButton.styleFrom(
                  fixedSize: const Size.fromHeight(50),
                  backgroundColor:
                      isDark ? Colors.grey : theme.colorScheme.primaryContainer,
                ),
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: isDark ? Colors.white : Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(),
            const FadeInSlide(
              duration: 1.3,
              direction: FadeSlideDirection.btt,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Privacy Policy"),
                  Text("   -   "),
                  Text("Terms of Service"),
                ],
              ),
            ),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }
}
