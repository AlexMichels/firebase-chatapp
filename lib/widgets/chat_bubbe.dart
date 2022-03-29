import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({required this.text, required this.sender, required this.isUser});
  bool isUser;
  String text;
  String sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: isUser? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(sender, style: TextStyle(fontSize: 12, color: Colors.black54),),
          Material(
            elevation: 8,
            borderRadius: isUser? BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20), bottomLeft:Radius.circular(20)):BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20), bottomLeft:Radius.circular(20)),
            color: isUser? Colors.lightBlue : Colors.grey[200],
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Text(text, style: TextStyle(color: isUser? Colors.white: Colors.black54, 
              fontSize: 18),),
            ),
          )
        ],
        
      ),
    );
  }
}