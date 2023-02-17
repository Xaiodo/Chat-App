import 'package:chat_appp/widgets/chat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser == null
          ? null
          : Future.value(
              FirebaseAuth.instance.currentUser,
            ),
      builder: (context, AsyncSnapshot<User?> futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chat')
              .orderBy(
                'createdAt',
                descending: true,
              )
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = snapshot.data!.docs;
            return ListView.builder(
              reverse: true,
              itemCount: documents.length,
              itemBuilder: (context, index) => MessageBubble(
                userImage: documents[index]['userImage'],
                username: documents[index]['username'],
                keyy: ValueKey(documents[index].id),
                message: documents[index]['text'],
                isMe: documents[index]['userId'] == futureSnapshot.data!.uid,
              ),
            );
          },
        );
      },
    );
  }
}
