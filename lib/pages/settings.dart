import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:morrsy/auth/authservices.dart';
import 'package:morrsy/auth/signin.dart';
import 'package:morrsy/pages/homepage.dart';
import 'package:morrsy/widgets/mybutton.dart';

class SettingsPage extends StatefulWidget {
  
   SettingsPage({super.key, });

  @override
  State<SettingsPage> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  bool isSwitched = true;
  bool isSound = true;

  void signout(BuildContext context){
    final _auth = Authservices();
    _auth.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => SignIn()));
  }
  @override
  
  

  Widget build(BuildContext context) {
    final String userID = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(centerTitle: true,primary: true,
      backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: Icon(Icons.arrow_back)),
            title: Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder<DocumentSnapshot>( future: FirebaseFirestore.instance
                              .collection('users')
                              .doc(userID)
                              .get(), builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if(snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }
                                if (!snapshot.hasData || !snapshot.data!.exists) {
                                  return Text('user data not available');
                                }
                                var userData = snapshot.data!.data() as Map<String, dynamic>?;
                                // Extract the username
                String username = userData?['username'] ?? 'Unknown User';
            
              return Column(children: [
                
                                  
                /// account details section
                /// 
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Profile', style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    ],
                  ), 
                  SizedBox(height: 20,),
                // profile image
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(child: Center(child: Container(height: 120, width: 120, decoration: BoxDecoration(color: Colors.grey.shade300, ), child: Icon(Icons.person_add_alt_1, size: 40, color: Colors.grey.shade600,),)), borderRadius: BorderRadius.circular(100),),
                    ],
                    
                  ), SizedBox(height: 10,),
              
                  // user email
              
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(username, style: TextStyle(color: Colors.lightBlueAccent),),
                  )],),
                  SizedBox(height: 30,),
              
                /// sound and notifications
                /// 
                /// notifications
                Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [Text('Notifications', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),)],),
              
                SizedBox(height: 20,),
              // switch
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Enable notifications',
                        style: TextStyle(
                            color: Colors.grey,
                            
                            fontWeight: FontWeight.bold),
                      ),
                      Center(
                          child: Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            print(isSwitched);
                          });
                        },
                        activeColor: Colors.blue,
                        activeTrackColor: Colors.lightBlueAccent,
                      )),
                    ],
                  ),
                  SizedBox(height: 10,),
              /// sound 
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sound',
                        style: TextStyle(
                            color: Colors.grey,
                            
                            fontWeight: FontWeight.bold),
                      ),
              
                      // switch
                      Center(
                          child: Switch(
                        value: isSound,
                        onChanged: (value) {
                          setState(() {
                            isSound = value;
                            print(isSound);
                          });
                        },
                        activeColor: Colors.blue,
                        activeTrackColor: Colors.lightBlueAccent,
                      )),
                    ],
                  ),
                  SizedBox(height: 30,),
                /// signout and support
                /// 
                
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [Text('Support', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),)],),
                SizedBox(height: 40,),
              
                // signout button
                MyButton(text: 'Sign Out', onTap: () => signout(context),)
              ]);
            }
          ),
        ),
      ),
    );
  }
}
