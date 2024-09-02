import 'package:flutter/material.dart';
import 'package:morrsy/pages/newmessage.dart';
import 'package:morrsy/pages/settings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          children: [
            // search bar

            SearchBar(),
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
            SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
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
            SizedBox(height: 5,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => NewMessage()));
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
    );
  }
}
