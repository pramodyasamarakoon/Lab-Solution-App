import 'package:flutter/material.dart';
import '../models/patient.dart'; // Import the Patient model

class ChatScreen extends StatefulWidget {
  final Patient patient; // Passing the patient data to the chat screen

  const ChatScreen({super.key, required this.patient});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();
  List<String> messages = []; // List to hold chat messages
  bool isSending = false; // To track the sending state of the message

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  // Function to simulate sending a message
  void sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add(_messageController.text); // Add the message to the list
        _messageController.clear(); // Clear the input field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back when clicked
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.patient.image),
              radius: 20,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.patient.name,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  '${widget.patient.age} years, ${widget.patient.gender}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call, color: Colors.black),
            onPressed: () {
              // Handle call action (for now, just a print statement)
              print('Call button tapped');
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // Handle more options action (for now, just a print statement)
              print('More options button tapped');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Display the chat messages in a ListView
          Expanded(
            child: ListView.builder(
              reverse: true, // To show the latest messages at the bottom
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isSender =
                    index % 2 == 0; // Alternate between sender and receiver
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                  child: Align(
                    alignment:
                        isSender ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSender ? Colors.blue[200] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Text(
                        messages[index],
                        style: TextStyle(
                            color: isSender ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Input and attach file section at the bottom
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {
                    // Handle attachment (file, image, etc.)
                    print('Attach file clicked');
                  },
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey, 
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border:
                            InputBorder.none, // No border for the text field
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10), // Padding inside the input field
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(isSending ? Icons.hourglass_empty : Icons.send),
                  onPressed: () {
                    if (!isSending) {
                      setState(() {
                        isSending = true;
                      });
                      sendMessage();
                      Future.delayed(const Duration(seconds: 1), () {
                        setState(() {
                          isSending = false;
                        });
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
