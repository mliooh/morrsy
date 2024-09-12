import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:morrsy/chat/chatservice.dart';
import 'package:morrsy/pages/chatscreen.dart';
import 'package:morrsy/pages/homepage.dart';

class UsersPage extends StatelessWidget {
  final String userID;
  const UsersPage({super.key, required this.userID});

  Future<void> getUserData(String userID) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .get();
      // check if doc exists

      if (userDoc.exists) {
        Map<String, dynamic>? userData =
            userDoc.data() as Map<String, dynamic>?;
        if (userData != null) {
          String username = userData['username'];
          String email = userData['email'];
          print('Name: $username, Email: $email');
        } else {
          print('user not found');
        }
      } else {
        print('user dosent exist');
      }
    } catch (e) {
      print('error fetching users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          primary: true,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
              icon: Icon(Icons.arrow_back)),
          title: Text(
            'Users',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        body: Center(
            child: Column(children: [
          // list of users
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.hasData) {
                  var users = snapshot.data!.docs;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, Index) {
                          var userData =
                              users[Index].data() as Map<String, dynamic>;
                          String username =
                              userData['username'] ?? 'username not found';
                          String email = userData['email'] ?? 'email not found';
                          String recipientID = users[Index].id;
                          return GestureDetector(
                            onTap: () {
                              // Generate chatID using currentUserID and recipientID
          String currentUserID = FirebaseAuth.instance.currentUser!.uid;
          
          String chatID = Chatservice.getChatID(currentUserID, recipientID);

          // Navigate to ChatScreen with the correct chatID and recipientID
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                chatID: chatID,
                recipientID: recipientID,
              ),
            ),
          );
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey.shade400,
                                child: Icon(Icons.person, color: Colors.black,),
                              ),
                              title: Text(
                                username,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                email,
                              ),
                            ),
                          );
                        }),
                  );
                }return Text('no user');
              })
        ])));
  }
}


// fetch user data
