import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final bool ObscureText;
  const MyTextfield({super.key, required this.text, required this.controller, required this.ObscureText});

  @override
  Widget build(BuildContext context) {
    //bool isPassword = true;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(controller:controller,
      obscureText: ObscureText,
        
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade600)),
            fillColor: Colors.grey.shade200,
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlueAccent)),
            hintText: text,
            filled: true,
            hintStyle: TextStyle(color: Colors.grey.shade700)),
      ),
    );
  }
}

class LoadingOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54, // Semi-transparent background
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent), 
        ),
      ),
    );
  }
}