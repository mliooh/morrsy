import 'package:flutter/material.dart';

class InputMessageBar extends StatelessWidget {
  final TextEditingController messageController = TextEditingController();

  // user message 
  
  
   InputMessageBar({super.key, });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
                controller: messageController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Type your message here...',
                  hintStyle: TextStyle(color: Colors.grey.shade800),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), ),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlueAccent)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade600)),
                  filled: true,
                  fillColor: Colors.grey.shade300
                ),
              ),
    );
  }
}