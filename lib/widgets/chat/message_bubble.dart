import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.keyy,
    required this.username,
    required this.message,
    required this.isMe,
    required this.userImage,
  }) : super(key: key);
  final Key keyy;
  final String message;
  final bool isMe;
  final String? username;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    const radius = 15.0;

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Theme.of(context).colorScheme.secondary : Colors.grey,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(radius),
              topRight: const Radius.circular(radius),
              bottomLeft: isMe
                  ? const Radius.circular(radius)
                  : const Radius.circular(0),
              bottomRight: isMe
                  ? const Radius.circular(0)
                  : const Radius.circular(radius),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Row(
            children: [
              Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username ?? 'error',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.background,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(
                width: 8,
              ),
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(userImage),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
