import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  
  // user in app 
  final TextEditingController _usercontroller = TextEditingController();
   SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        onChanged: (value) {onSearch;},
        controller: _usercontroller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey.shade800),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Icon(Icons.search, color: Colors.black,),
          ),
          
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade600)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlueAccent)),
        ),
      ),
    );
  }
}

// function for loading users on the app on a drop down from the search bar

void onSearch(String query) {
  FirebaseFirestore.instance
    .collection('users')
    .where('displayName', isGreaterThanOrEqualTo: query)
    .get()
    .then((snapshot) {
      // Update the UI with the list of matching users
    });
}