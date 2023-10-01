import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Modell för ett chattmeddelande
class ChatMessage {
  final String senderId;
  final String message;
  final Timestamp timestamp;
  final String? receiverId;

  ChatMessage({
    required this.senderId,
    required this.message,
    required this.timestamp,
    this.receiverId,
  });

  // Skapar ett ChatMessage-objekt från ett Firestore-dokument
  factory ChatMessage.fromDocument(DocumentSnapshot doc) {
    try {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return ChatMessage(
        senderId: data['senderId'] ?? "",
        message: data['text'] ?? "",
        timestamp: data['timestamp'] as Timestamp? ?? Timestamp.now(),
        receiverId: data.containsKey('receiverId') ? data['receiverId'] : null,
      );
    } catch (e) {
      print("Fel vid skapande av ChatMessage från dokument: $e");
      throw e;
    }
  }
}

class MessageScreen extends StatefulWidget {
  final User user;

  const MessageScreen({Key? key, required this.user}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final _messageController = TextEditingController();
  List<ChatMessage> messages = [];
  late final String chatID;

  @override
  void initState() {
    super.initState();
    chatID = createChatID("j1VKII8Fgac9elpRXSMsTderaFJ3", "szNOIofQQ0PYqAr5slgmEiSl9Ku2");
  }

  @override
  Widget build(BuildContext context) {
    // Använder MediaQuery för att hämta skärmens bredd och höjd
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        // Här visas meddelandena
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('chats')
                .doc(chatID)
                .collection('messages')
                .orderBy('timestamp')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Något gick fel'));
              }

              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              messages = snapshot.data!.docs.map((doc) {
                return ChatMessage.fromDocument(doc);
              }).toList();

              return ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  bool isMe = messages[index].senderId == widget.user.uid;
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue[100] : Colors.green[100],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Text(messages[index].message),
                        ),
                        Text(
                          messages[index].timestamp.toDate().toString(),
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        // Här är textfältet och skicka-knappen
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(color: Colors.grey[400]!),
                  ),
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Skriv ett meddelande...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.02),  // Använder skärmens bredd för att sätta ett dynamiskt avstånd
              IconButton(
                icon: Icon(Icons.send),
                onPressed: _sendMessage,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Skapar ett unikt chatt-ID baserat på användar-ID:n
  String createChatID(String uid1, String uid2) {
    return (uid1.compareTo(uid2) < 0) ? uid1 + "_" + uid2 : uid2 + "_" + uid1;
  }

  // Skickar meddelande till Firestore
  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('chats').doc(chatID).collection('messages').add({
        'senderId': widget.user.uid,
        'text': _messageController.text,
        'timestamp': Timestamp.now(),
      });
      _messageController.clear();
    }
  }
}
