import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String hintTxt;
  const CustomTextField({super.key, required this.hintTxt});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.07,
      padding: const EdgeInsets.all(0),
      child: TextField(
        cursorColor: Colors.black54,
        decoration: InputDecoration(
            fillColor: Colors.grey.shade200,
            hintText: hintTxt,
            hintStyle: const TextStyle(
                height: 0,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(color: Colors.transparent)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(color: Colors.transparent)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(color: Colors.transparent))),
      ),
    );
  }
}
