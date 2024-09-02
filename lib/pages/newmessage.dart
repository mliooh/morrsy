import 'package:flutter/material.dart';
import 'package:morrsy/pages/homepage.dart';
import 'package:morrsy/support/morse.dart';
import 'package:morrsy/widgets/inputmessage.dart';
import 'package:morrsy/widgets/searchfielsd.dart';

class NewMessage extends StatefulWidget {
  
  const NewMessage({super.key, });

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {

  TextEditingController messageController = TextEditingController();
  String morseCode = '';
  void _convertToMorse() {
    setState(() {
      morseCode = convertToMorse(messageController.text);
    });
  }

  @override



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          'Message',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(children: [
          //
          // contact search
        
        SizedBox(height: 30,),
        ContactSearch(),
          // input message text field
        SizedBox(height: 30,),
        InputMessageBar(),
          // convert to morse and send option
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            // convert to morse
            ElevatedButton(
              onPressed: _convertToMorse , child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Convert to Morse', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
            ), style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade300, )),
            ElevatedButton(
                      onPressed: () {},
                      child: Text('Send', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlueAccent, )
                    ),
                    
            // send message
          ],),
        )
          // play morse
        
        ],),
      ),
    );
  }
}

class ContactSearch extends StatelessWidget {
  // users in app 
  final TextEditingController _usercontroller = TextEditingController();
   ContactSearch({super.key,  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(controller: _usercontroller,
        onChanged: (value) {onSearch;},
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          hintText: 'To',
          hintStyle: TextStyle(color: Colors.grey.shade600),
          suffixIcon: Icon(Icons.people_outline),
          filled: true,
          fillColor: Colors.grey.shade300,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade600)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlueAccent)),
        ),
      ),
    );
  }
}

