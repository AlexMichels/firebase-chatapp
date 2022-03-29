import 'package:chatapp/widgets/chat_bubbe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StreamBuilderChatArea extends StatelessWidget {
  const StreamBuilderChatArea({
    Key? key,
    required FirebaseFirestore firestore,
    required this.mail, 
  }) : _firestore = firestore, super(key: key);

  final FirebaseFirestore _firestore;
  final String? mail;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('timestamp').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(
            backgroundColor: Colors.lightBlue,
          ),);}
          final messages = snapshot.data!.docs.reversed;
          List<ChatBubble> messageWidgets = [];
          for(var message in messages){
            
            final messageText = message['text'];
            final messageSender = message['sender'];
            final isUser = messageSender == mail ? true : false;
            final messageWidget = ChatBubble(text: messageText, sender: messageSender, isUser : isUser);
            
            messageWidgets.add(messageWidget);
          }
         return Expanded(
           child: ListView(
             reverse: true,
             children: messageWidgets,
           ),
         );
        
        
        });
  }
}