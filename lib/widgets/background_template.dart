import 'dart:ui';

import 'package:flutter/material.dart';

class StackTemplate extends StatelessWidget {
  final Widget child;
  final Widget? child2;
  const StackTemplate({Key? key, required this.child, this.child2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            // color: Colors.red,
            image: DecorationImage(
              image: ExactAssetImage('assets/admk.png', scale: 0.1),
              alignment: Alignment
                  .center, // Align image at the center of the container
              // fit: BoxFit.cover, // Cover the entire container
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.0),
              ),
            ),
          ),
        ),

        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.center,
                colors: [
                  const Color(0xFFf07954).withOpacity(0.5),
                  Colors.transparent
                ],
              ),
            ),
          ),
        ),
        child, // Child widget goes here
        child2 ?? Container(), // Child2 widget goes here
      ],
    );
  }
}
