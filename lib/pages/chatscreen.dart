import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:morrsy/chat/chatservice.dart';

import 'package:morrsy/support/morse.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController _messageController = TextEditingController();
  final String chatID;
  final String recipientID;
  
  

  ChatScreen({required this.chatID, required this.recipientID, });
  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(recipientID).get(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return Scaffold(appBar: AppBar(backgroundColor: Colors.lightBlueAccent,
          title: Text('Loading...', style: TextStyle(color: Colors.white)),), body: Center(child: CircularProgressIndicator()),);
        }
        var recipientData =  snapshot.data!.data() as Map<String, dynamic>;
        String recipientName = recipientData['username'];

        return Scaffold(
          backgroundColor: Colors.white,
          
          appBar: AppBar(
            backgroundColor: Colors.lightBlueAccent,
            title: Row(
              children: [
                CircleAvatar(
                  child: Icon(Icons.person, color: Colors.black,),
                ),
                SizedBox(width: 10),
                
                Text(recipientName, style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('chats')
                        .doc(chatID)
                        .collection('messages')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
            
                      var messages = snapshot.data!.docs;
            
                      return ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          var message = messages[index];
                          bool isSender = message['senderID'] == FirebaseAuth.instance.currentUser!.uid;
            
                          return Align(
                            alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSender ? Colors.blue : Colors.grey,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.symmetric(vertical: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(message['text'], style: TextStyle(color: Colors.white)),
                                  if (message['morseCode'] != null)
                                    Text(message['morseCode'], style: TextStyle(color: Colors.white, fontSize: 10)),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:  20.0),
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send, color: Colors.lightBlueAccent,),
                        onPressed: () async {
                          String text = _messageController.text.trim();
                          if (text.isNotEmpty) {
                            await Chatservice().sendMessage(recipientID, text, convertToMorse(text));
                            _messageController.clear();
                          }
                        },
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      hintText: 'Type a message', hintStyle: TextStyle(color: Colors.grey.shade400)
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}


/*class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
    appBar: AppBar(
      // profile picture
      backgroundColor: Colors.lightBlueAccent,
      leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: Icon(Icons.arrow_back, color: Colors.white,)),

      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(child: Container(color: Colors.amber,),),
        SizedBox(width: 20,),
        // username
        
        Text('my name,' ,style: TextStyle(color: Colors.white,fontSize: 18),)
        ],),
      ),
      

    ),
    body: Column(children: [],),);
  }
}

class ChatBox extends StatelessWidget {
  const ChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container();
  }
}*/