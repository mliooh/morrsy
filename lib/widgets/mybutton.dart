import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const MyButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
                child: Text(
              text,
              style: TextStyle(color: Colors.white),
            )),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.lightBlueAccent),
        ),
      ),
    ));
  }
}
