import 'package:chatapp/constants.dart';
import 'package:chatapp/widgets/chat_bubbe.dart';
import 'package:chatapp/widgets/stream_builder_chat_area.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //! Setup Firebase here
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var loggedInUser;
  late String message;
  TextEditingController textEditingController = TextEditingController();

void messagesStream()async{
 await for(var snapshot in _firestore.collection('messages').snapshots()){
 for (var message in snapshot.docs){
   print(message.data());
 }
 } 
}

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        
      }
    } catch (e) {
      print(e);
      print('FEHLER');
    }
  }

  void getMessages()async{
   final fireMessage = await _firestore.collection('messages').get();
   for(var message in fireMessage.docs){
     print(message.data());
   }
   
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
               
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            
            StreamBuilderChatArea(firestore: _firestore, mail: _auth.currentUser?.email,),
                Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textEditingController ,
                      onChanged: (value) {
                        message = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _firestore.collection('messages').add(
                        {'text': message, 'sender': loggedInUser.email, 'timestamp': FieldValue.serverTimestamp(),}
                      );
                      textEditingController.clear();
                    
                  
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



