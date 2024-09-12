import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:morrsy/pages/chatscreen.dart';
import 'package:morrsy/pages/newmessage.dart';

import 'package:morrsy/pages/settings.dart';
import 'package:morrsy/pages/userspage.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('participants',
                arrayContains: FirebaseAuth.instance.currentUser!.uid)
            .orderBy('lastMessageTime', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Scaffold(
              floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: SizedBox(
            //height: 50,
            //width: 50,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => UsersPage(userID: '',)));
              },
              child: Icon(
                Icons.message_outlined,
                color: Colors.white,
              ),
              backgroundColor: Colors.lightBlueAccent,
            )),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Chats',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        automaticallyImplyLeading: false,
        // settings icon

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                )),
          )
        ],
        backgroundColor: Colors.white,
      ),
              body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                                    children: [
                    Container(
                      width: double.infinity,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      child: Image.asset(
                        'lib/assets/newchat.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Start a chat',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => UsersPage(userID: '',)));
                          },
                          child: Text(
                            'Find people and start chatting with them',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                                    ],
                                  ),
                  )),
            );
          }
          var chatDocs = snapshot.data!.docs;

          return Scaffold(
            floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: SizedBox(
            //height: 50,
            //width: 50,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => UsersPage(userID: '',)));
              },
              child: Icon(
                Icons.message_outlined,
                color: Colors.white,
              ),
              backgroundColor: Colors.lightBlueAccent,
            )),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Chats',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        automaticallyImplyLeading: false,
        // settings icon

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                )),
          )
        ],
        backgroundColor: Colors.white,
      ),
            body: ListView.builder(
                itemCount: chatDocs.length,
                itemBuilder: (context, index) {
                  var chatDoc = chatDocs[index];
                  var lastMessage = chatDoc['lastMessage'];
                  var lastMessageTime = chatDoc['lastMessageTime'].toDate();

                  String otherUserID = chatDoc['participants'].firstWhere(
                      (participant) =>
                          participant !=
                          FirebaseAuth.instance.currentUser!.uid,
                          orElse: () => '');
                          if (otherUserID.isEmpty) {
                            return SizedBox.shrink();
                          }
                  return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(otherUserID)
                          .get(),
                      builder: (context,
                          AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                        if (!userSnapshot.hasData) {
                          return SizedBox.shrink();
                        }
                        var userData = userSnapshot.data!;
                        return ListTile(tileColor: Colors.grey.shade200, 
                          leading: SizedBox(width: 50,
                            child: ClipRRect(borderRadius: BorderRadius.circular(100),
                              child: Center(child: Container(decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(100)), child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.person, ),
                              ))),
                            ),
                          ),
                          title: Text(userData['username']),
                          subtitle: Text(lastMessage),
                          trailing: Text(style: TextStyle(color: Colors. lightBlueAccent), TimeOfDay.fromDateTime(lastMessageTime)
                              .format(context)),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChatScreen(chatID: chatDoc.id, recipientID: otherUserID, )));
                          },
                        );
                      });
                }),
          );
        });
  }
}





    /*return Scaffold(
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: SizedBox(
            height: 50,
            width: 50,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => NewMessage()));
              },
              child: Icon(
                Icons.message_outlined,
                color: Colors.white,
              ),
              backgroundColor: Colors.lightBlueAccent,
            )),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Chats',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        automaticallyImplyLeading: false,
        // settings icon

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Settings()));
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                )),
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              // search bar

              // SearchBar(),
              SizedBox(
                height: 30,
              ),
              // if user has no chats start chat screen is displayed
              Center(
                child: Container(
                  width: double.infinity,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Image.asset(
                    'lib/assets/newchat.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Start a chat',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ChatScreen()));
                    },
                    child: Text(
                      'Find people and start chatting with them',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
              // if user has chats users chats bar is displayed
            ],
          ),
        ),
      ),
    );
  }
}


 (context, AsyncSnapshot<DocumentSnapshot> userSnapShot){
          if(!userSnapShot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
var userData = userSnapShot.data!;
return ListTile(leading: ClipRRect(child: Container(color: Colors.amber,),), title: Text(userData['username']), subtitle: Text(lastMessage), trailing: Text(TimeOfDay.fromDateTime(lastMessageTime).format(context)), onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatScreen()))},)

        }*/