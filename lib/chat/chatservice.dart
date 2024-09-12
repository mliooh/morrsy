import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chatservice {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> sendMessage(String recipientID, String text, String morseCode) async {
    String currentUserID = FirebaseAuth.instance.currentUser!.uid;
    
    String chatID = getChatID(currentUserID, recipientID);

    DocumentReference chatRef = _db.collection('chats').doc(chatID);
    DocumentSnapshot chatSnapshot = await chatRef.get();

    if (!chatSnapshot.exists) {
      await chatRef.set({
        'participants': [currentUserID, recipientID],
        'lastMessage': text,
        'lastMessageTime': FieldValue.serverTimestamp(),
      });
      
    } else 
    {
      await chatRef.collection('messages').add({
        'senderID': currentUserID,
      'text': text,
      'morseCode': morseCode,
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': false,
      });
    }
    
}
static String getChatID(String user1ID, String user2ID) {
    return user1ID.hashCode <= user2ID.hashCode
        ? '$user1ID-$user2ID'
        : '$user2ID-$user1ID';
  }}