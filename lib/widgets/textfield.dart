import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextInputType type;
  final IconData? icon1;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validate;

  const CustomTextField({
    Key? key,
    required this.icon,
    required this.validate,
    required this.controller,
    this.type = TextInputType.text,
    required this.hintText,
    this.icon1,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff1f2128),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20)),
      child: TextFormField(
        validator: validate,
        controller: controller,
        keyboardType: type,
        onChanged: onChanged,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 23.0, right: 15),
            child: Icon(
              icon,
              size: 30,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Icon(
              icon1,
              size: 30,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[700]),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey, width: 2.0),
          ),
        ),
      ),
    );
  }
}
