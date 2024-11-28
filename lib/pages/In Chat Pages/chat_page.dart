import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importing for DateFormat
import '../../models/patient.dart'; // Import the Patient model

class ChatScreen extends StatefulWidget {
  final Patient patient; // Passing the patient data to the chat screen

  const ChatScreen({super.key, required this.patient});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();
  ScrollController _scrollController = ScrollController(); // ScrollController for ListView
  List<Map<String, String>> messages = []; // List to hold chat messages with timestamps
  bool isSending = false; // To track the sending state of the message

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose(); // Dispose the ScrollController
    super.dispose();
  }

  // Function to simulate sending a message
  void sendMessage() {
    if (_messageController.text.isNotEmpty) {
      String messageText = _messageController.text;
      String timestamp = _getFormattedTime(); // Get the current time in formatted string

      setState(() {
        // Add message with its timestamp
        messages.add({'message': messageText, 'timestamp': timestamp});
        _messageController.clear(); // Clear the input field
      });

      // Scroll to the bottom after sending a message
      _scrollToBottom();
    }
  }

  // Function to scroll to the bottom of the ListView
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Function to format the current time
  String _getFormattedTime() {
    final now = DateTime.now();
    final formatter = DateFormat('hh:mm a'); // Format as "hh:mm AM/PM"
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Ensure the keyboard doesn't push the input field offscreen
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
              controller: _scrollController, // Attach the controller to ListView
              reverse: false, // Ensure messages are added from the bottom
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index]['message'] ?? '';
                final timestamp = messages[index]['timestamp'] ?? '';

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 15.0),
                  child: Align(
                    alignment: Alignment.centerRight, // Align all messages to the Right
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFDCF8C6), // WhatsApp sending message color
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            message,
                            style: TextStyle(color: Colors.black), // Text color for the message
                          ),
                          const SizedBox(height: 5), // Space between message and timestamp
                          Text(
                            timestamp,
                            style: TextStyle(
                              color: Colors.grey[600], // Timestamp color
                              fontSize: 12, // Smaller text for the timestamp
                            ),
                          ),
                        ],
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
                      color: Colors.grey[200], // Light grey background
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none, // No border for the text field
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10), // Padding inside the input field
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
